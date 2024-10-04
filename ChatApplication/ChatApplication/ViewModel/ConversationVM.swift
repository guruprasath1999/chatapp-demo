//
//  ConversationVM.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import UIKit

class ConversationViewModel {
    
    var reloadTableView: (()->())?
    var cellViewModels = [RealmConversation]()
    
    func getData(){
        if ConversationDao.fetchconversation().isEmpty {
            createCell()
        } else {
            cellViewModels = ConversationDao.fetchconversation()
            self.reloadTableView?()
        }
        
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> RealmConversation {
        return cellViewModels[indexPath.row]
    }
    

    
    func createCell(){
        cellViewModels.removeAll()
        var vms = [RealmConversation]()
        if UserDao.fetchUsingUserId(id: CustomUserDefaults.userId ?? "").isUserLoggedIn {
            
            vms.append(RealmConversation(id: UUID().uuidString, lastMessage: RealmMessage(), profileImageName: "Electrical", conversationName: "Electrical engineering", userId: CustomUserDefaults.userId ?? ""))
            vms.append(RealmConversation(id: UUID().uuidString, lastMessage: RealmMessage(), profileImageName: "Mechanical", conversationName: "Mechanical engineering", userId: CustomUserDefaults.userId ?? ""))
            vms.append(RealmConversation(id: UUID().uuidString, lastMessage: RealmMessage(), profileImageName: "Civil", conversationName: "Civil engineering", userId: CustomUserDefaults.userId ?? ""))
            vms.append(RealmConversation(id: UUID().uuidString, lastMessage: RealmMessage(), profileImageName: "Automobile", conversationName: "Automobile engineering", userId: CustomUserDefaults.userId ?? ""))
            vms.append(RealmConversation(id: UUID().uuidString, lastMessage: RealmMessage(), profileImageName: "Chemical", conversationName: "Chemical engineering", userId: CustomUserDefaults.userId ?? ""))
            vms.append(RealmConversation(id: UUID().uuidString, lastMessage: RealmMessage(), profileImageName: "Computer", conversationName: "Computer science engineering", userId: CustomUserDefaults.userId ?? ""))
            ConversationDao.createUser(chatlist: vms)
        } else {
            cellViewModels = vms
        }
        cellViewModels = vms
        self.reloadTableView?()
    }
}


