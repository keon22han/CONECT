
import Foundation

class Food {
    
    var foodImageDBUrl: String?
    
    var foodName: String?
    // 칼로리
    var calories: Float?
    // 탄수화물
    var carbohydrates: Float?
    // 당류
    var sugars: Float?
    // 단백질
    var protein: Float?
    // 지방
    var fat: Float?
    // 포화지방
    var saturatedFat: Float?
    // 트랜스지방
    var transFat: Float?
    // 콜레스테롤
    var cholesterol: Float?
    // 나트륨
    var sodium: Float?
    
    init() {
        self.foodImageDBUrl = ""
        self.foodName = "foodName"
        self.calories = 0
        self.carbohydrates = 0
        self.sugars = 0
        self.protein = 0
        self.fat = 0
        self.saturatedFat = 0
        self.transFat = 0
        self.cholesterol = 0
        self.sodium = 0
    }
    
    // 새로운 음식 생성 시에만 호출
    init(foodImageDBUrl: String, foodName: String, calories: Float?, carbohydrates: Float?, sugars: Float?, protein: Float?, fat: Float?, saturatedFat: Float?, transFat: Float?, cholesterol: Float?, sodium: Float?) {
        self.foodImageDBUrl = foodImageDBUrl
        self.foodName = foodName
        self.calories = calories
        self.carbohydrates = carbohydrates
        self.sugars = sugars
        self.protein = protein
        self.fat = fat
        self.saturatedFat = saturatedFat
        self.transFat = transFat
        self.cholesterol = cholesterol
        self.sodium = sodium
    }
    
    public func toValues() -> [String: Any?] {
        let values = ["foodImageDBUrl": self.foodImageDBUrl, "foodName": self.foodName, "calories": self.calories, "carbohydrates": self.carbohydrates, "sugars": self.sugars, "protein": self.protein, "fat": self.fat, "saturatedFat": self.saturatedFat, "transFat": self.transFat, "cholesterol": self.cholesterol, "sodium": self.sodium!] as [String : Any?]
        
        return values
    }
    
    public func setValue(fieldName: String, fieldValue: Any?) {
        switch fieldName {
        case "foodImageDBUrl" :
            self.foodImageDBUrl = (fieldValue as! String)
        case "foodName" :
            self.foodName = (fieldValue as! String)
        case "calories" :
            self.calories = (fieldValue as! Float)
        case "carbohydrates" :
            self.carbohydrates = (fieldValue as! Float)
        case "sugars" :
            self.sugars = (fieldValue as! Float)
        case "protein" :
            self.protein = (fieldValue as! Float)
        case "fat" :
            self.fat = (fieldValue as! Float)
        case "saturatedFat" :
            self.saturatedFat = (fieldValue as! Float)
        case "transFat" :
            self.transFat = (fieldValue as! Float)
        case "cholesterol" :
            self.cholesterol = (fieldValue as! Float)
        case "sodium" :
            self.sodium = (fieldValue as! Float)
            
        default:
            return
        }
    }
}
