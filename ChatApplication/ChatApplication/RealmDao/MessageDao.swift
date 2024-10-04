//
//  MessageDao.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import Foundation
import RealmSwift

class MessageDao: NSObject {
    static let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    // Save User to Local DB
    class func createMessage(message: RealmMessage) {
        do {
            try realm.write {
                realm.add(message, update: .all)
            }
        } catch let error as NSError {
            realm.cancelWrite()
            print(error.localizedDescription)
        }
    }
    
    
    class func fetchAllMessages(sessionId: String) -> [RealmMessage] {
        return Array(realm.objects(RealmMessage.self).where{ $0.sessionId == sessionId && $0.userID == CustomUserDefaults.userId }).reversed()
    }
    
    
}
