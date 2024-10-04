//
//  SenderMessageDocumentTVC.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import UIKit

class MessageDocumentTVC: UITableViewCell {

    @IBOutlet var messageView: UIView!
    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var imageDateTimeLbl: UILabel!
    @IBOutlet var documentDetailsLbl: UILabel!
    @IBOutlet var mediaImageHCons: NSLayoutConstraint!
    @IBOutlet var mediaImageWCons: NSLayoutConstraint!
    @IBOutlet var documentDetailsHCons: NSLayoutConstraint!
    @IBOutlet var documentTextLbl: UILabel!
    
    
    
    class func getIdentifier(isSender: Bool) -> String {
        return isSender ? "SenderMessageDocumentTVC" : "RecevierMessageDocumentTVC"
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
        
        if message.getDocumentType == .pdf {
            mediaImageHCons.constant = 141
            documentDetailsHCons.constant = 43
            mediaImageView.isHidden = false
        } else {
            documentDetailsHCons.constant = 60
            mediaImageView.isHidden =  true
            mediaImageHCons.constant = 60
        }
    
        if FileManager.default.fileExists(atPath: message.getDocumentPathUrl(isThumbnail: true).path) {
            if let data = NSData(contentsOf: message.getDocumentPathUrl(isThumbnail: true)) {
                    mediaImageView.image = UIImage(data: data as Data)
                } else {
                    print("Unable to load image from file URL")
                }
            } else {
                print("File does not exist at the specified path")
            }
        documentTextLbl.text = "\(message.message ?? "").\(message.fileType)"
        
        mediaImageWCons.constant = 310
        documentTextLbl.text = message.message
        imageDateTimeLbl.text = DateUtils.convertToDate(dateString: message.createdAt, format: .serverTimeFormate)?.getLocalStringBasedOn(format: .chatTimeFormate).appending("") ?? ""
    }
    
    @IBAction func actionOnViewMedia(sender: Any) {
        delegate?.openPdfViewController(message: message)
    }
    
}
