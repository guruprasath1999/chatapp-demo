//
//  RealmUser.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import ObjectMapper
import ObjectMapperAdditions
import RealmSwift

class RealmUser: Object, Mappable {
    @Persisted(primaryKey: true) var id: String? = ""
    @Persisted var email: String? = ""
    @Persisted var userName: String? = ""
    @Persisted var password: String? = ""
    @Persisted var isUserLoggedIn: Bool? = false
    
    // Custom initializer
        convenience init(id: String?, email: String?, userName: String?, password: String?, isUserLoggedIn: Bool?) {
            self.init() // Call the Realm Object initializer
            self.id = id
            self.email = email
            self.userName = userName
            self.password = password
            self.isUserLoggedIn = isUserLoggedIn
        }
        
        // ObjectMapper required initializer
        required convenience init?(map: ObjectMapper.Map) {
            self.init()
        }
        
    
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["_id"]
        email <- map["email"]
        userName <- map["userName"]
        password <- map["password"]
        isUserLoggedIn <- map["isUserLoggedIn"]
        
        
    }
}

