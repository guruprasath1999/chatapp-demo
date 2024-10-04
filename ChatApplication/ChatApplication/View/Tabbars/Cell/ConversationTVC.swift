//
//  ConversationTVC.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import UIKit

class ConversationTVC: UITableViewCell {
    
    @IBOutlet var sessionNameL: UILabel!
    @IBOutlet var lastMessageTimeL: UILabel!
    @IBOutlet var lastMessageL: UILabel!
    @IBOutlet var messageStatusV: UIView!
    @IBOutlet var profileIV: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageStatusV.layer.masksToBounds = true
        messageStatusV.setCornerRadius(radius: messageStatusV.bounds.width / 2, borderColor: UIColor.white, borderWidth: 1.5)
        profileIV.layer.masksToBounds = true
        profileIV.layer.cornerRadius = profileIV.bounds.width / 2
    }
    
    // ConfigureCell - It will show to the users pagination details
    /// - Parameter index: configureCell(index)
    func configureCell(conversation: RealmConversation) {
        
        let isLastMessageEmpty = conversation.lastMessage?.tempMessageId?.isEmpty ?? false
        
        switch MessageType(rawValue: conversation.lastMessage?.messageType?.uppercased() ?? "") ?? .TEXT {
            
        case .IMAGE:
            lastMessageL.text = "Image"
        case .DOCUMENT:
            lastMessageL.text = "Document"
        case .VIDEO:
            lastMessageL.text = "Video"
        case .TEXT, .START_OF_CHAT, .DATE:
            lastMessageL.text =  isLastMessageEmpty ? "Click to start the conversation" : conversation.lastMessage?.message
        }
        
        sessionNameL.text = conversation.conversationName
        
        profileIV.image = UIImage(named: conversation.profileImageName ?? "")
        lastMessageTimeL.isHidden = isLastMessageEmpty
        lastMessageTimeL.text = DateUtils.convertToDate(dateString: conversation.lastMessage?.createdAt, format: .serverTimeFormate)?.getChatTime() 
    }

    
}
