//
//  ApiCallVC.swift
//  ChatApplication
//
//  Created by NAM on 04/10/24.
//


import Foundation
import UIKit

class ApiCallVC: BaseVC {
    
    static let name = "ApiCallVC"
    static let storyBoard = "ApiCall"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> ApiCallVC {
        let vc = UIStoryboard(name: ApiCallVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: ApiCallVC.name) as! ApiCallVC
        return vc
    }
    
    var dataViewModel = ApiCallVM()
    
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Override Function
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCell()
        setNavigationBackBtn()
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSmallTitle(title: "ApiData")
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
        let cell = UINib(nibName: "UserDataTVC", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "UserDataTVC")
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            self.tableView.reloadData()
        }
        dataViewModel.VC = self
        dataViewModel.getData()
    }
}

extension ApiCallVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTVC", for: indexPath) as! UserDataTVC
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.configureCell(user: cellVM)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  100
        
    }
}




