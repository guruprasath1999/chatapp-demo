//
//  RealmConversation.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import ObjectMapper
import ObjectMapperAdditions
import RealmSwift

class RealmConversation: Object, Mappable {
    @Persisted(primaryKey: true) var id: String? = ""
    @Persisted var lastMessage: RealmMessage? = nil
    @Persisted var profileImageName:  String? = ""
    @Persisted var conversationName: String? = ""
    @Persisted var userId: String? = ""
    
    
    // Custom initializer
        convenience init(id: String?, lastMessage: RealmMessage?, profileImageName: String?, conversationName: String?,userId: String?) {
            self.init() // Call the Realm Object initializer
            self.id = id
            self.lastMessage = lastMessage
            self.profileImageName = profileImageName
            self.conversationName = conversationName
            self.userId = userId
        }
        
        // ObjectMapper required initializer
        required convenience init?(map: ObjectMapper.Map) {
            self.init()
        }
        
    
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["_id"]
        lastMessage <- map["lastMessage"]
        profileImageName <- map["profileImageName"]
        conversationName <- map["conversationName"]
        userId <- map["userId"]
        
        
    }
}
