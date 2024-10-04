//
//  SenderMessageTextTVC.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import SDWebImage
import UIKit
import QuickLook
import MobileCoreServices
import AVFAudio
import ActiveLabel


protocol MessageDelegate: AnyObject {
    func actionOnViewMedia(message: RealmMessage)
    func openPdfViewController(message: RealmMessage)}

class MessageTextTVC: UITableViewCell {
    // MARK: - IBOutlet Declaration
    
    @IBOutlet var quotedImageContainerView: UIView!
    @IBOutlet var quotedImageView: UIImageView!
    @IBOutlet var messageStatusIV: UIImageView!
    @IBOutlet var messageView: UIView!
    @IBOutlet var replyView: UIView!
    @IBOutlet var forwardView: UIView!
    @IBOutlet var messageLbl: ActiveLabel!
    @IBOutlet var dateTimeLbl: UILabel!
    @IBOutlet var quotedMessageLbl: UILabel!
    @IBOutlet var quotedMessageUserNameLbl: UILabel!
    @IBOutlet var quotedLineV: UIView!
    @IBOutlet var quotedMessageV: UIView!
    @IBOutlet var senderNameLbl: UILabel!
    @IBOutlet var senderNameView: UIView!
    @IBOutlet var infoImageView: UIImageView!
    @IBOutlet var infoBtn: UIButton!
    @IBOutlet var forwardCheckBox: UIImageView!
    @IBOutlet var blockedIV: UIImageView!
    @IBOutlet var tickHCons: NSLayoutConstraint!
    @IBOutlet var tickWCons: NSLayoutConstraint!
    @IBOutlet var dateLCons: NSLayoutConstraint!
    @IBOutlet var forwardScapeWCons: NSLayoutConstraint!
    @IBOutlet var forwardIV: UIImageView!
    
    // MARK: - Variable Declaration
    
    weak var delegate: MessageDelegate?
    var message = RealmMessage()

    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.setCornerRadius(radius: 12)
        transform = CGAffineTransform(scaleX: 1, y: -1)
        quotedMessageV.setCornerRadius(radius: 10)
        setupContextLbl()
    }
    
    override func didMoveToSuperview() { self.contentView.layoutIfNeeded() }
    
    // MARK: - Supporting Functions
    
    class func getIdentifier(isSender: Bool) -> String {
        return isSender ? "SenderMessageTextTVC" : "ReceiverMessageTextTVC"
    }
    
   

    
    // MARK: - ConfigureCell
    
    func configureCell(message: RealmMessage ,sessions: RealmConversation) {
        self.message = message
        dateTimeLbl.text = DateUtils.convertToDate(dateString: message.createdAt, format: .serverTimeFormate)?.getLocalStringBasedOn(format: .chatTimeFormate).appending("") ?? ""
        if message.isDeleted {
            messageLbl.font = UIFont.italicSystemFont(ofSize: 16.5)
            messageLbl.text = "    This message has been deleted.\n "
        } else {
            messageLbl.font = UIFont.systemFont(ofSize: 18.0)
            messageLbl.text = message.message?.trim.appending( "                  ") ?? ""
            messageLbl.text =  messageLbl.text
            if let labelWidth = messageLbl?.frame.width, labelWidth > (UIScreen.main.bounds.width * (0.6)) || messageLbl.actualNumberOfLines > 1  {
                messageLbl.text = messageLbl.text?.trimmingCharacters(in: .whitespaces).appending("\n")
            }else if messageLbl.text?.count ?? 0 > 35 && messageLbl.actualNumberOfLines == 1{
                messageLbl.text = messageLbl.text?.trimmingCharacters(in: .whitespaces).appending("\n")
            }else{
                messageLbl.text = messageLbl.text
            }
            messageStatusIV.image = UIImage(named: "delivered")
        }
    }
    
    
    
}

extension MessageTextTVC {
    
    func setupContextLbl() {
        
        
        messageLbl.customize { label in
            label.enabledTypes = [.url,.hashtag,.mention]
            label.URLColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            label.hashtagColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            label.mentionColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            label.handleURLTap { url in
                // Handle URL tap, you can open it in Safari or perform any other action
                UIApplication.shared.open(url)
            }
            
            label.handleHashtagTap { email in
                // Handle URL tap, you can open it in Safari or perform any other action
                if let url = URL(string: "mailto:\(email)") {
                    UIApplication.shared.open(url)
                }
            }
            
            label.handleMentionTap { phoneNumber in
                // Handle URL tap, you can open it in Safari or perform any other action
                if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
    
   
