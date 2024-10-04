//
//  ConversationVC.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import UIKit

class ConversationVC: BaseVC {
    
    static let name = "ConversationVC"
    static let storyBoard = "Conversation"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> ConversationVC {
        let vc = UIStoryboard(name: ConversationVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: ConversationVC.name) as! ConversationVC
        return vc
    }
    
    var dataViewModel = ConversationViewModel()
    
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Override Function
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCell()
        
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLargeTitle(title: "Conversations")
        initViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
    }

    
    func registerNibCell() {
        let cell = UINib(nibName: "ConversationTVC", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "ConversationTVC")
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            self.tableView.reloadData()
        }
        dataViewModel.getData()
    }
}

extension ConversationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationTVC", for: indexPath) as! ConversationTVC
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.configureCell(conversation: cellVM)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatVC.instantiateFromStoryboard()
        chatVC.conversation = dataViewModel.getCellViewModel( at: indexPath )
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  80
        
    }
}




