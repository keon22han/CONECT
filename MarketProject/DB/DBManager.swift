
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

final class DBManager {
    
    static let instance = DBManager()
    
    private var userIdentifier: String?
    
    private init() {
        
    }
    
    public func getUserId() -> String {
        guard self.userIdentifier != nil else {
            return ""
        }
        
        return self.userIdentifier!
    }
    
    public func getUserInformation(userDBId: String, completion: @escaping((Bool, User?) -> Void)) {
        let userInfo = User(userDBId: "", nickName: "", userEmail: "", userPassword: "")
        
        let userRef = Database.database().reference(withPath: "Users/\(userDBId)")
        
        userRef.observeSingleEvent(of: .value, with : { dataSnapshot in
            if !dataSnapshot.exists() {
                completion(false, nil)
                return
            }
            
            guard let data = dataSnapshot.value as? [String: Any?] else {
                return
            }
            
            for (key, value) in data {
                do {
                    try userInfo.setField(fieldName: key, fieldValue: value)
                } catch {
                    continue
                }
            }
            completion(true, userInfo)
        })
    }
    
    public func signUp(email: String, password: String, completion: @escaping((Bool, String?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            self.userIdentifier = authResult!.user.uid
            completion(true, nil)
        }
    }
    
    public func signIn(email: String, password: String, completion: @escaping ((Bool, String?) -> Void)) {
        // Firebase Auth Login
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("로그인 실패")
                completion(false, error.localizedDescription)
                return
            }
            
            print("로그인 성공")
            self.userIdentifier = authResult!.user.uid
            completion(true, nil)
        }
    }
    
    public func uploadStoreData(storeData: Store) {
        let storeRef = Database.database().reference(withPath: "Stores/\(storeData.storeName)")
        
        let storeValues = storeData.getValues()
        
        storeRef.setValue(storeValues)
    }
    
    public func getSingleStoreData(storeName: String, completion: @escaping((Bool, Store?) -> Void)) {
        let storeRef = Database.database().reference(withPath: "Stores/\(storeName)")
        storeRef.observeSingleEvent(of: .value, with: { snapShot in
            if !snapShot.exists() {
                completion(false, nil)
                return
            }
            
            guard let data = snapShot.value as? [String: String] else {
                completion(false, nil)
                return
            }
            
            let store = Store()
            
            for (key, value) in data {
                store.setValue(fieldName: key, fieldValue: value)
            }
            
            completion(true, store)
        })
    }
    
    public func getAllStoreData(completion: @escaping((Bool, [Store]?) -> Void)) {
        let storeRef = Database.database().reference(withPath: "Stores")
        storeRef.observeSingleEvent(of: .value, with: { snapShot in
            if !snapShot.exists() {
                completion(false, nil)
                return
            }
            
            guard let data = snapShot.value as? [String: Any?] else {
                completion(false, nil)
                return
            }
            
            var stores = [Store]()
            
            for (_, value) in data {
                let store = Store()
                for (valueKey, valueVal) in (value as! [String: String])  {
                    store.setValue(fieldName: valueKey, fieldValue: valueVal)
                }
                stores.append(store)
            }
            
            completion(true, stores)
        })
    }
    
    public func uploadUserData(userInfo: User) {
        
        let userInfoArray = userInfo.getUserInfoArray()
        let userRef = Database.database().reference(withPath: "Users")
        print(userInfo.userDBId)
        userRef.child(userInfo.userDBId).setValue(userInfoArray)
    }
    
    public func reserveSharedTable(tableInfo: ShareTableReservationInfo) {
        
        // 테이블 정보 저장
        let tableRef = getTableRef(tableNumber: tableInfo.tableNumber!)
        let reserveValues : [String: Any] = ["reserver": tableInfo.reserverDBId!, "tableNumber": tableInfo.tableNumber!, "time": tableInfo.time!]
        tableRef.child(tableInfo.date!).child(tableInfo.time!).setValue(reserveValues)
        
        // 유저 테이블 예약 정보 저장
        let tableReserveValues : [String: Any] = ["tableNumber": tableInfo.tableNumber!, "date": tableInfo.date!, "time": tableInfo.time!]
        let randomUUID = UUID().uuidString
        let userTableRef = Database.database().reference(withPath: "Users/\(self.userIdentifier!)/reservedTableInfo/\(randomUUID)")
        userTableRef.setValue(tableReserveValues)
    }
    
    public func getUserReservationData(userDBId: String, completion: @escaping((Bool, [ShareTableReservationInfo]?) -> Void)) {
        
        let userReservedTableRef = Database.database().reference(withPath: "Users/\(userDBId)/reservedTableInfo")
        
        userReservedTableRef.observeSingleEvent(of: .value, with: { snapShot in
            if !snapShot.exists() {
                completion(false, nil)
                print("유저 테이블 예약 정보가 없습니다.")
                return
            }
            
            guard let data = snapShot.value as? [String: Any?] else {
                completion(false, nil)
                print("유저 테이블 예약 정보 데이터 형식이 잘못되었습니다.")
                return
            }
            
            var shareTableReservationInfos = [ShareTableReservationInfo]()
            
            // key : 각 랜덤 예약 Id
            for (_, value) in data {
                guard let valueVal = value as? [String: Any?] else {
                    completion(false, nil)
                    print("각 예약 Id에 대한 Value가 잘못되었습니다.")
                    return
                }
                
                let singleShareTableReservationInfo = ShareTableReservationInfo(reserverDBId: self.getUserId())
                
                for (key, singleValue) in valueVal {
                    singleShareTableReservationInfo.setValue(fieldName: key, fieldValue: singleValue)
                }
                
                shareTableReservationInfos.append(singleShareTableReservationInfo)
            }
            
            completion(true, shareTableReservationInfos)
        })
    }
    
    
    public func cancelSingleReservation(tableNumber: Int, reservedDate: String, reservedTime: String, completion: @escaping(() -> Void)) {
        let tableLabelList = ["TableA", "TableB", "TableC", "TableD"]
        
        let reservedRef = Database.database().reference(withPath: "SharedTables/\(tableLabelList[tableNumber])/\(reservedDate)/\(reservedTime)")
        reservedRef.removeValue()
        
        let userReservedRef = Database.database().reference(withPath: "Users/\(DBManager.instance.getUserId())/reservedTableInfo")
        
        userReservedRef.observeSingleEvent(of: .value, with: { snapShot in
            if !snapShot.exists() {
                print("doesn't exist")
            }
            else {
                guard let data = snapShot.value as? [String: Any?] else {
                    print("snapShot values error")
                    return
                }
                
                for (key, value) in data {
                    guard let singleValue = value as? [String: Any?] else {
                        print("snapShot singleValue error")
                        return
                    }
                    
                    if (singleValue["date"] as! String) == reservedDate && (singleValue["time"] as! String) == reservedTime {
                        userReservedRef.child(key).removeValue()
                        completion()
                    }
                }
            }
        })
    }
    
    // 몇개의 테이블 사용 가능한지
    public func getTableAvailabilityCount(date: String, tableNumber: Int, completion: @escaping((Int) -> Void)) {
        var availableCount = 0
        getTableTimeStatus(date: date, tableNumber: tableNumber) { statusList, usersInfo in
            for status in statusList {
                if status.value {
                    availableCount += 1
                }
            }
            completion(availableCount)
        }
    }
    
    // 날짜, 테이블 번호에 해당하는 각 시간대 가능 여부
    public func getTableTimeStatus(date: String, tableNumber: Int, completion: @escaping(([String: Bool], [String: User?]) -> Void)) {
        
        var usersInfo: [String: User?] = ["09:00": nil, "11:00": nil, "13:00": nil, "15:00": nil, "17:00": nil, "19:00": nil]
        var timeStatusList = ["09:00": true, "11:00": true, "13:00": true, "15:00": true, "17:00": true, "19:00": true]
        
        let tableRef = getTableRef(tableNumber: tableNumber)
        
        let dispatchGroup = DispatchGroup()
        
        tableRef.child(date).observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() {
                completion(timeStatusList, usersInfo)
                return
            }
            
            guard let data = snapshot.value as? [String: Any?] else {
                completion(timeStatusList, usersInfo)
                return
            }
            
            for (key, value) in data {
                if let reserverId = (value as? NSMutableDictionary)?["reserver"] as? String {
                    // 비동기 작업 시작
                    dispatchGroup.enter()
                    
                    self.getUserInformation(userDBId: reserverId) { exist, user in
                        if exist {
                            usersInfo[key] = user!
                        }
                        timeStatusList[key] = false
                        dispatchGroup.leave() // 비동기 작업 완료
                    }
                } else {
                    timeStatusList[key] = false
                }
            }
            
            // 모든 비동기 작업이 완료된 후 호출
            dispatchGroup.notify(queue: .main) {
                completion(timeStatusList, usersInfo)
            }
        })
    }
    
    private func getTableRef(tableNumber: Int) -> DatabaseReference {
        let tables = ["TableA", "TableB", "TableC", "TableD"]
        
        let tableRef = Database.database().reference(withPath: "SharedTables/\(tables[tableNumber])")
        
        return tableRef
    }
    
    public func reserveShoppingCart(shoppingCartIdentifier: String) {
        let shoppingCartsRef = Database.database().reference(withPath: "ShoppingCarts/\(shoppingCartIdentifier)")
        shoppingCartsRef.updateChildValues(["usingUserDBId": getUserId()])
    }
    
    // 냉장고 정보 저장
    public func createRefrigerator(refrigeratorName: String) {
        let refrigeratorValue = ["refrigeratorName": refrigeratorName]
        Database.database().reference(withPath: "Refrigerators/\(refrigeratorName)").setValue(refrigeratorValue)
    }
    
    public func setRefrigeratorFood(refrigeratorName: String, foodName: String, foodCount: Int) {
        let refrigeratorFoodRef = Database.database().reference(withPath: "Refrigerators/\(refrigeratorName)/FoodsCountInfo")
        let refrigeratorFoodChild = refrigeratorFoodRef.child("\(foodName)")
        
        let values = ["Counts": foodCount]
        refrigeratorFoodChild.setValue(values)
    }
    
    // 특정 냉장고 음식 갯수 변경 
    public func editRefrigeratorFood(refrigeratorName: String, foodName: String, foodCount: Int) {
        let refrigeratorFoodRef = Database.database().reference(withPath: "Refrigerators/\(refrigeratorName)/FoodsCountInfo/\(foodName)/Counts")
        refrigeratorFoodRef.observeSingleEvent(of: .value, with: { snapShot in
            guard let data = snapShot.value as? Int else {
                return
            }
            refrigeratorFoodRef.setValue(data + foodCount)
        })
    }
    
    public func createFoodInfo(food: Food) {
        let foodRef = Database.database().reference(withPath: "Foods/\(food.foodName!)")
        
        let values = food.toValues()
        foodRef.setValue(values)
    }
    
    // 이미지 업로드 시 호출, 이미지 Url completion 으로 받아 foodImageUrl 저장
    public func uploadImageToDB(image: UIImage, completion: @escaping((String?) -> Void)) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageURL = UUID().uuidString
        
        let firebaseReference = Storage.storage().reference().child("\(imageURL)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            if error != nil {
                completion(nil)
            }
            
            firebaseReference.downloadURL { fullImageURL, _ in
                completion(fullImageURL?.absoluteString)
            }
        }
    }
    
    public func downloadImageFromDB(imageURL: String, completion: @escaping((UIImage?) -> Void)) {
        
        let megaByte = Int64(1 * 1024 * 1024)
        
        if !(imageURL.hasPrefix("gs://") || imageURL.hasPrefix("http://") || imageURL.hasPrefix("https://")) {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference(forURL: imageURL)
        
        storageRef.getData(maxSize: megaByte, completion: { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: imageData)
            completion(image)
        })
    }
    
    public func getFoodInfo(foodName: String, completion: @escaping((Food?) -> Void)) {
        let foodInfoRef = Database.database().reference(withPath: "Foods/\(foodName)")
        foodInfoRef.observeSingleEvent(of: .value, with: { snapShot in
            guard let foodInfo = snapShot.value as? [String: Any] else {
                completion(nil)
                return
            }
            
            let food = Food()
            
            for (foodFieldName, foodFieldValue) in foodInfo {
                food.setValue(fieldName: foodFieldName, fieldValue: foodFieldValue)
            }
            
            completion(food)
        })
    }
    
    // 배열의 갯수로 냉장고 수 파악 가능
    public func getRefrigeratorsBaseInfo(completion: @escaping (Bool, [RefrigeratorInformation]?) -> Void) {
        let refrigeratorsRef = Database.database().reference(withPath: "Refrigerators")
        refrigeratorsRef.observeSingleEvent(of: .value, with: { refrigerSnapShot in
            guard let refrigerData = refrigerSnapShot.value as? [String: Any] else {
                completion(false, nil)
                return
            }
            
            var refrigeratorsInfo = [RefrigeratorInformation]()
            
            for (_, refrigerValue) in refrigerData {
                let refrigeratorInfo = RefrigeratorInformation()
                
                guard let refrigerFields = refrigerValue as? [String: Any] else {
                    completion(false, nil)
                    return
                }
                
                for (refrigerFieldName, refrigerFieldValue) in refrigerFields {
                    refrigeratorInfo.setField(fieldName: refrigerFieldName, fieldValue: refrigerFieldValue)
                }
                
                refrigeratorsInfo.append(refrigeratorInfo)
            }
            completion(true, refrigeratorsInfo)
        })
    }
    
    public func uploadPostInfo(post: Post) {
        let postRef = Database.database().reference(withPath: "Posts")
        postRef.child(post.postDBId).setValue(post.getValues())
    }
    
    public func getPostsInfoByProductType(productType: String, completion: @escaping(([Post]?) -> Void)) {
        
        var posts = [Post]()
        
        let postRef = Database.database().reference(withPath: "Posts")
        postRef.observeSingleEvent(of: .value, with: { snapShot in
            guard let postData = snapShot.value as? [String: Any] else {
                completion(nil)
                return
            }
            
            for (postDBId, postValues) in postData {
                guard let postValues = postValues as? [String: Any] else {
                    completion(nil)
                    return
                }
                
                if((postValues["productType"] as! String) == productType) {
                    var post = Post()
                    for (postFieldName, postFieldValue) in postValues {
                        post.setField(fieldName: postFieldName, fieldValue: postFieldValue)
                    }
                    posts.append(post)
                }
            }
            
            completion(posts)
        })
    }
    
    public func getPostsInfo(sortOrder: SortingCriteria, keyword: String = "", completion: @escaping(([Post]?) -> Void)) {
        
        var posts = [Post]()
        
        let postRef = Database.database().reference(withPath: "Posts")
        postRef.observeSingleEvent(of: .value, with: { snapShot in
            guard let postData = snapShot.value as? [String: Any] else {
                completion(nil)
                return
            }
            
            for (postDBId, postValues) in postData {
                guard let postValues = postValues as? [String: Any] else {
                    completion(nil)
                    return
                }
                
                let post = Post()
                for (postFieldName, postFieldValue) in postValues {
                    post.setField(fieldName: postFieldName, fieldValue: postFieldValue)
                }
                posts.append(post)
            }
            
            switch sortOrder {
            case .latest :
                // 최신순 나열
                posts.sort { first, second in
                    return first.postDate > second.postDate
                }
                
            case .oldest :
                // 오래된 순 나열
                posts.sort { first, second in
                    return first.postDate < second.postDate
                }
            case .accuracy:
                // 정확도 순 나열
                posts.sort { first, second in
                    let firstContainsKeyword = first.postTitle.lowercased().contains(keyword.lowercased())
                    let secondContainsKeyword = second.postTitle.lowercased().contains(keyword.lowercased())
                    
                    if firstContainsKeyword && !secondContainsKeyword {
                        return true
                    } else if !firstContainsKeyword && secondContainsKeyword {
                        return false
                    } else {
                        // 단어 포함 여부가 동일한 경우 최신순으로 정렬
                        return first.postDate > second.postDate
                    }
                }
            }
            
            
            completion(posts)
        })
    }
}
