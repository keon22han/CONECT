//
//  Post.swift
//  MarketProject
//
//  Created by 한건희 on 9/2/24.
//

import Foundation

class Post {
    var postDBId: String
    var authorDBId: String
    var postImageUrl: String
    var postTitle: String
    var postContent: String
    var productPrice: Int
    var productType: String
    var postDate: String
    var isOnSale: Bool
    
    init(postDBId: String, authorDBId: String, postImageUrl: String, postTitle: String, postContent: String, productPrice: Int, productType: String, postDate: String, isOnSale: Bool) {
        self.postDBId = postDBId
        self.authorDBId = authorDBId
        self.postImageUrl = postImageUrl
        self.postTitle = postTitle
        self.postContent = postContent
        self.productPrice = productPrice
        self.productType = productType
        self.postDate = postDate
        self.isOnSale = isOnSale
    }
    
    init() {
        self.postDBId = ""
        self.authorDBId = ""
        self.postImageUrl = ""
        self.postTitle = ""
        self.postContent = ""
        self.productPrice = 0
        self.productType = ""
        self.postDate = ""
        self.isOnSale = false
    }
    
    public func getValues() -> [String: Any] {
        return ["postDBId": self.postDBId, "authorDBId": self.authorDBId, "postImageUrl": self.postImageUrl,"postTitle": self.postTitle, "postContent": self.postContent, "productPrice": self.productPrice, "productType": self.productType, "postDate": self.postDate, "isOnSale": self.isOnSale]
    }
    
    public func setField(fieldName: String, fieldValue: Any) {
        switch fieldName {
        case "postDBId" :
            self.postDBId = (fieldValue as! String)
        case "authorDBId" :
            self.authorDBId = (fieldValue as! String)
        case "postImageUrl" :
            self.postImageUrl = (fieldValue as! String)
        case "postTitle" :
            self.postTitle = (fieldValue as! String)
        case "postContent" :
            self.postContent = (fieldValue as! String)
        case "productPrice" :
            self.productPrice = (fieldValue as! Int)
        case "productType" :
            self.productType = (fieldValue as! String)
        case "postDate" :
            self.postDate = (fieldValue as! String)
        case "isOnSale" :
            self.isOnSale = (fieldValue as! Bool)
        default:
            print("fieldName not valid")
            return
        }
    }
}
