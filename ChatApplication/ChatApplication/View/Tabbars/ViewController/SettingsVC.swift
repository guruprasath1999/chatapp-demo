//
//  ProfileVC.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import UIKit

class SettingsVC: BaseVC {
    
    static let name = "SettingsVC"
    static let storyBoard = "Settings"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> SettingsVC {
        let vc = UIStoryboard(name: SettingsVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: SettingsVC.name) as! SettingsVC
        return vc
    }
    
    // MARK: - Override Function'
    
    @IBOutlet var nameL: UILabel!
    @IBOutlet var cornerV: [UIView]!
    @IBOutlet var emailL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameL.text = CustomUserDefaults.name
        emailL.text = CustomUserDefaults.emailID
        setUpLargeTitle(title: "Settings")
        cornerV.forEach({  $0.setCornerRadius(radius: 12,borderColor: UIColor(hexStr: "3D8A98"),borderWidth: 1) })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func actionOnApi() {
        let apiVC = ApiCallVC.instantiateFromStoryboard()
        navigationController?.pushViewController(apiVC, animated: true)
    }
    
    @IBAction func actionOnLogout() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default) { (_: UIAlertAction!) in })
        alertController.addAction(UIAlertAction(title: "Yes", style: .default) { (_: UIAlertAction!) in
            if let user = UserDao.fetchUserEmailId(emailId: CustomUserDefaults.emailID ?? "") {
                UserDao.saveOrUpdateUserLoginStatus(user: user, isLoggedIn: false)
            }
            Utils.setRootController(rootVCType: .loginVC)
        })
        present(alertController, animated: true, completion: nil)
        
       
    }
}



