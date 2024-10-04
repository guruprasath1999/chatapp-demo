//
//  SplashVC.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import Foundation
import UIKit

class SplashVC: BaseVC {
    
    static let name = "SplashVC"
    static let storyBoard = "Main"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> SplashVC {
        let vc = UIStoryboard(name: SplashVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: SplashVC.name) as! SplashVC
        return vc
    }
    
    // MARK: - Override Function
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableDarkStatusBar = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
       
    }
    
    @objc func timerAction() {
        if  UserDao.fetchUsingUserId(id: CustomUserDefaults.userId ?? "").isUserLoggedIn {
            Utils.setRootController(rootVCType: .tabbarVC)
        } else {
            Utils.setRootController(rootVCType: .onboardVC)
        }
       
       }

}


