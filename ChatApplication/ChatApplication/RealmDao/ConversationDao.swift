//
//  ConversationDao.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import Foundation
import RealmSwift

class ConversationDao: NSObject {
    static let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    // Save User to Local DB
    class func createUser(chatlist: [RealmConversation]) {
        do {
            try realm.write {
                realm.add(chatlist, update: .all)
            }
        } catch let error as NSError {
            realm.cancelWrite()
            print(error.localizedDescription)
        }
    }
    
    class func updateSession(session: RealmConversation, message:RealmMessage) {
        do {
            try realm.write {
                session.lastMessage = message
            }
        }catch let error as NSError {
            realm.cancelWrite()
            fatalError(error.localizedDescription)
        }
    }
    
    
    class func fetchconversation() -> [RealmConversation] {
        return Array(realm.objects(RealmConversation.self).where{ $0.userId == CustomUserDefaults.userId}.sorted(byKeyPath: "lastMessage.createdAt", ascending: false))
    }
    
    
}


