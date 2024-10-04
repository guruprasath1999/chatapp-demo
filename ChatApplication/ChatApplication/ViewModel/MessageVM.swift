//
//  MessageVM.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import UIKit

class MessageViewModel {
    
    var reloadTableView: (()->())?
    var cellViewModels = [RealmMessage]()
    var conversation = RealmConversation()
    
    func getData(){
        let currentDate = Date().getUTCStringBasedOn(format: .serverTimeFormate)
        cellViewModels = MessageDao.fetchAllMessages(sessionId: conversation.id ?? "")
        if cellViewModels.isEmpty {
            
            let dateMessage = RealmMessage()
            dateMessage.senderId = CustomUserDefaults.userId ?? ""
            dateMessage.messageType = MessageType.DATE.rawValue
            dateMessage.tempMessageId = UUID().uuidString
            dateMessage.sessionId = conversation.id ?? ""
            dateMessage.createdAt = currentDate
            dateMessage.userID = CustomUserDefaults.userId
            MessageDao.createMessage(message: dateMessage)
            cellViewModels.append(dateMessage)
            
            let message = RealmMessage()
            message.senderId = CustomUserDefaults.userId ?? ""
            message.messageType = MessageType.START_OF_CHAT.rawValue
            message.sessionId = conversation.id ?? ""
            message.message = "Start Of Chat"
            message.userID = CustomUserDefaults.userId
            message.tempMessageId = UUID().uuidString
            message.createdAt = currentDate
            MessageDao.createMessage(message: message)
            cellViewModels.append(message)
            ConversationDao.updateSession(session: conversation, message: message)
            
        } 
        
        self.reloadTableView?()
    }
    
    
    func getMessageType( at indexPath: IndexPath )  -> MessageType {
        let messageType =  cellViewModels[indexPath.row].messageType
        return MessageType(rawValue: messageType?.uppercased() ?? "") ?? .TEXT
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> RealmMessage {
        return cellViewModels[indexPath.row]
    }
    
    func sendMessage(messageType: MessageType, text: String,tempId: String, fileType: String = "",docMessage: String = "") {
        
        let currentDate = Date().getUTCStringBasedOn(format: .serverTimeFormate)
        
        if !isSameDay(dateString1: cellViewModels.first?.createdAt ?? "", dateString2: currentDate, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ") {
            let message = RealmMessage()
            message.senderId = CustomUserDefaults.userId ?? ""
            message.messageType = MessageType.DATE.rawValue
            message.tempMessageId = UUID().uuidString
            message.userID = CustomUserDefaults.userId
            message.createdAt = currentDate
            message.sessionId = conversation.id ?? ""
            MessageDao.createMessage(message: message)
        }
        
        let message = RealmMessage()
        message.senderId = CustomUserDefaults.userId ?? ""
        message.messageType = messageType.rawValue
        message.message = MessageType.DOCUMENT.rawValue == messageType.rawValue ? docMessage : text
        message.fileType = fileType
        message.sessionId = conversation.id ?? ""
        message.userID = CustomUserDefaults.userId
        message.tempMessageId = MessageType.TEXT.rawValue == messageType.rawValue ? UUID().uuidString : tempId
        message.createdAt = currentDate
        MessageDao.createMessage(message: message)
        ConversationDao.updateSession(session: conversation, message: message)
        getData()
    }
    func isSameDay(dateString1: String, dateString2: String, format: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)  // Set to UTC
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")  // Ensure locale is consistent
        
        // Parse the date strings
        guard let date1 = dateFormatter.date(from: dateString1),
              let date2 = dateFormatter.date(from: dateString2) else {
            print("Invalid date format.")
            return false
        }
        
        // Compare if both dates fall on the same day
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}



