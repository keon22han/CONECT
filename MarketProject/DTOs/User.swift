//
//  Reserver.swift
//  MarketProject
//
//  Created by 한건희 on 8/22/24.
//

import Foundation

class User {
    var userDBId : String
    var nickName : String
    var userEmail : String
    var userPassword : String
    
    init(userDBId: String, nickName: String, userEmail: String, userPassword: String) {
        self.userDBId = userDBId
        self.nickName = nickName
        self.userEmail = userEmail
        self.userPassword = userPassword
    }
    
    public func getUserInfoArray() -> [String: String] {
        let array = ["userDBId": self.userDBId, "nickName": self.nickName, "userEmail": self.userEmail, "userPassword": self.userPassword]
        
        return array
    }
    
    public func setField(fieldName: String, fieldValue: Any?) throws {
        switch fieldName {
        case "userDBId":
            self.userDBId = fieldValue as! String
            
        case "nickName":
            self.nickName = fieldValue as! String
            
        case "userEmail":
            self.userEmail = fieldValue as! String
            
        case "userPassword":
            self.userPassword = fieldValue as! String
            
        default:
            // TODO: 던지는 에러 수정 필요
            throw NSError()
        }
    }
}
