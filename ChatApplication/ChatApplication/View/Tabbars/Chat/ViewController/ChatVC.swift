//
//  ChatVC.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//


import AVFoundation
import AVKit
import BSImagePicker
import GrowingTextView
import MobileCoreServices
import Photos
import RealmSwift
import UIKit
import WebKit
import ZLImageEditor
import QuickLook


class ChatVC: BaseVC {
    
    static let name = "ChatVC"
    static let storyBoard = "Chat"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> ChatVC {
        let vc = UIStoryboard(name: ChatVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: ChatVC.name) as! ChatVC
        return vc
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var appShareB: UIButton!
    @IBOutlet var actionSheetB: UIButton!
    
    @IBOutlet var conversationName: UILabel!
    
    //  These IBOutlets related to date
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var dateView: UIView!
    
    ///  These IBOutlets related to forward
    @IBOutlet var forwardBtn: UIButton!
    @IBOutlet var forwardCancelBtn: UIButton!
    @IBOutlet var forwardView: UIView!
    
    
    ///  These IBOutlets related to action
    @IBOutlet var newUnReadLbl: UILabel!
    @IBOutlet var newUnReadView: UIView!
    
    ///  These IBOutlets related to Quote message
    @IBOutlet var quoteContainerView: UIView!
    @IBOutlet var quoteImageView: UIImageView!
    @IBOutlet var quoteMessageLabel: UILabel!
    @IBOutlet var quoteNameLabel: UILabel!
    @IBOutlet var quoteView: UIView!
    @IBOutlet var scrollBottomBtn: UIButton!
    
    ///  These IBOutlets related to MessageTyping
    @IBOutlet var textView: GrowingTextView!
    @IBOutlet var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var selectedMessageLbl: UILabel!
    @IBOutlet var inputToolbar: UIView!
    
    
    var imagePicker = UIImagePickerController()
    var reloadIndexPath: IndexPath?
    
    ///  These Variables related to Menu Animation.
    var menuActions: [UIAction] = []
    var animationMenuIndexPath = Int()
    
    var conversation = RealmConversation()
    var dataViewModel = MessageViewModel()
    let previewGenerator = QLThumbnailGenerator()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBackBtn()
        dataViewModel.conversation = conversation
        registerTableViewCell()
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupData()
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = true
        setUpSmallTitle(title: conversation.conversationName ?? "")
        initViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            self.tableView.reloadData()
        }
        dataViewModel.getData()
    }
    
    func setupData() {
        
        textView.delegate = self
        textView.layer.cornerRadius = 4.0
        textViewBottomConstraint.constant = 8
        textView.inputAccessoryView = UIView(frame: CGRect.zero)
        textView.reloadInputViews()
        textView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        textView.setCornerRadius(radius: textView.frame.size.height / 2)
        
        // Add observers for keyboard notifications
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension ChatVC: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}


extension ChatVC {
    
    /// RegisterTableView Cell
    func registerTableViewCell() {
        
        let senderMessageTextNib = UINib(nibName: "SenderMessageTextTVC", bundle: nil)
        tableView.register(senderMessageTextNib, forCellReuseIdentifier: "SenderMessageTextTVC")
        let receiverMessageTextNib = UINib(nibName: "ReceiverMessageTextTVC", bundle: nil)
        tableView.register(receiverMessageTextNib, forCellReuseIdentifier: "ReceiverMessageTextTVC")
        
        
        // MessageVideo
        let senderMessageVideoNib = UINib(nibName: "SenderMessageVideoTVC", bundle: nil)
        tableView.register(senderMessageVideoNib, forCellReuseIdentifier: "SenderMessageVideoTVC")
        let receiverMessageVideoNib = UINib(nibName: "ReceiverMessageVideoTVC", bundle: nil)
        tableView.register(receiverMessageVideoNib, forCellReuseIdentifier: "ReceiverMessageVideoTVC")
        
        // MessageDocument
        let senderMessageDocumentNib = UINib(nibName: "SenderMessageDocumentTVC", bundle: nil)
        tableView.register(senderMessageDocumentNib, forCellReuseIdentifier: "SenderMessageDocumentTVC")
        let receiverMessageDocumentNib = UINib(nibName: "RecevierMessageDocumentTVC", bundle: nil)
        tableView.register(receiverMessageDocumentNib, forCellReuseIdentifier: "RecevierMessageDocumentTVC")
        
        // MessageImage
        let senderMessageImagetNib = UINib(nibName: "SenderMessageImageTVC", bundle: nil)
        tableView.register(senderMessageImagetNib, forCellReuseIdentifier: "SenderMessageImageTVC")
        let receiverMessageImageNib = UINib(nibName: "ReceiverMessageImageTVC", bundle: nil)
        tableView.register(receiverMessageImageNib, forCellReuseIdentifier: "ReceiverMessageImageTVC")
        
    }
}





