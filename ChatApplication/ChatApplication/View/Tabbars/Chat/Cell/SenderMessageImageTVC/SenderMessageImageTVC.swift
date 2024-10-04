//
//  SenderMessageImageTVC.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import UIKit

class MessageImageTVC: UITableViewCell {
    
    @IBOutlet var messageView: UIView!
    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var imageDateTimeLbl: UILabel!
    
    @IBOutlet var mediaImageHCons: NSLayoutConstraint!
    @IBOutlet var mediaImageWCons: NSLayoutConstraint!
    
    
    
    class func getIdentifier(isSender: Bool) -> String {
        return isSender ? "SenderMessageImageTVC" : "ReceiverMessageImageTVC"
    }
    
    weak var delegate: MessageDelegate?
    var message = RealmMessage()

    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.setCornerRadius(radius: 12)
        mediaImageView.setCornerRadius(radius: 12)
        transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    func configureCell(message: RealmMessage ,sessions: RealmConversation) {
        self.message = message
    
            if FileManager.default.fileExists(atPath: message.getImagePathUrl.path) {
                if let data = NSData(contentsOf: message.getImagePathUrl) {
                    mediaImageView.image = UIImage(data: data as Data)
                } else {
                    print("Unable to load image from file URL")
                }
            } else {
                print("File does not exist at the specified path")
            }
        mediaImageWCons.constant = 255
        mediaImageHCons.constant = 310
        imageDateTimeLbl.text = DateUtils.convertToDate(dateString: message.createdAt, format: .serverTimeFormate)?.getLocalStringBasedOn(format: .chatTimeFormate).appending("") ?? ""
    }
    
    @IBAction func actionOnViewMedia(sender: Any) {
        delegate?.actionOnViewMedia(message: message)
    }
    
}
