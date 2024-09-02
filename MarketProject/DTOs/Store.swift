//
//  Store.swift
//  MarketProject
//
//  Created by 한건희 on 8/28/24.
//

import Foundation

class Store {
    var storeImageUrl: String
    var storeName: String
    var storeDescription: String
    var storeDetailDescription: String
    
    init() {
        self.storeImageUrl = ""
        self.storeName = ""
        self.storeDescription = ""
        self.storeDetailDescription = ""
    }
    
    init(storeImageUrl: String, storeName: String, storeDescription: String, storeDetailDescription: String) {
        self.storeImageUrl = storeImageUrl
        self.storeName = storeName
        self.storeDescription = storeDescription
        self.storeDetailDescription = storeDetailDescription
    }
    
    public func setValue(fieldName: String, fieldValue: String) {
        switch fieldName {
        case "storeImageUrl" :
            self.storeImageUrl = fieldValue
            
        case "storeName" :
            self.storeName = fieldValue
            
        case "storeDescription" :
            self.storeDescription = fieldValue
            
        case "storeDetailDescription" :
            self.storeDetailDescription = fieldValue
            
        default :
            return
        }
    }
    
    public func getValues() -> [String: String]{
        return ["storeImageUrl": self.storeImageUrl, "storeName": self.storeName, "storeDescription": self.storeDescription, "storeDetailDescription": self.storeDetailDescription]
    }
}
