//
//  UserDao.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import RealmSwift

class UserDao: NSObject {
    static let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))


    // Save User to Local DB
    class func createUser(user: RealmUser) {
        do {
            try realm.write {
                realm.add(user, update: .all)
            }
        } catch let error as NSError {
            realm.cancelWrite()
            print(error.localizedDescription)
        }
    }
    
   
    class func saveOrUpdateUserLoginStatus(user: RealmUser, isLoggedIn: Bool) {
            do {
                try realm.write {
                    user.isUserLoggedIn = isLoggedIn
                    realm.add(user, update: .all)
                }
            } catch let error as NSError {
                realm.cancelWrite()
                print(error.localizedDescription)
            }
        }
    
    class func saveOrUpdateUserLoginPassword(user: RealmUser, password: String) {
            do {
                try realm.write {
                    user.password = password
                    realm.add(user, update: .all)
                }
            } catch let error as NSError {
                realm.cancelWrite()
                print(error.localizedDescription)
            }
        }
    
    
    class func fetchUsers() -> [RealmUser] {
        return Array(realm.objects(RealmUser.self))
    }
    
    class func fetchUsingUserId(id: String) -> (data:RealmUser?,isUserLoggedIn: Bool) {
        let datas = Array(realm.objects(RealmUser.self).filter({ $0.id == id })).first
        return (datas,datas?.isUserLoggedIn ?? false)
    }

    class func fetchUserEmailId(emailId: String) -> RealmUser? {
        let datas = Array(realm.objects(RealmUser.self).filter({ $0.email == emailId })).first
        return datas
    }


    class func isUserFoundInDB() -> Bool {
        return realm.objects(RealmUser.self).isEmpty
    }
    
    
    
    
}

