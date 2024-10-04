//
//  LoginSignupVC.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import Foundation
import UIKit

class LoginSignupVC: BaseVC {
    
    static let name = "LoginSignupVC"
    static let storyBoard = "LoginSignup"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> LoginSignupVC {
        let vc = UIStoryboard(name: LoginSignupVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: LoginSignupVC.name) as! LoginSignupVC
        return vc
    }
    
    // MARK: - IBOutlet Declaration

    @IBOutlet var loginV: UIView!
    @IBOutlet var signupV: UIView!
    
    
    // MARK: - Override Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginV.setCornerRadius(radius: 8)
        signupV.setCornerRadius(radius: 8,borderColor: UIColor(hexStr: "3D8A98"),borderWidth: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - IBAction Methods
    
    @IBAction func actionOnLogin() {
        let loginVC = LoginVC.instantiateFromStoryboard()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    @IBAction func actionOnSignUp() {
        let signupVC = SignUpVC.instantiateFromStoryboard()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}


