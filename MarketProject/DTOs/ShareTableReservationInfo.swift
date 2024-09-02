
import Foundation

class ShareTableReservationInfo {
    var reserverDBId: String?
    var tableNumber: Int?
    var date: String?
    var time: String?
    
    init(reserverDBId: String) {
        self.reserverDBId = reserverDBId
    }
    
    init(reserverDBId: String, tableNumber: Int, date: String, time: String) {
        self.reserverDBId = reserverDBId
        self.tableNumber = tableNumber
        self.date = date
        self.time = time
    }
    
    public func setValue(fieldName: String, fieldValue: Any?) {
        switch fieldName {
        case "tableNumber" :
            self.tableNumber = fieldValue as? Int
            
        case "date" :
            self.date = fieldValue as? String
            
        case "time" :
            self.time = fieldValue as? String
            
        default:
            return
        }
    }
}
