//
//  LoginVC.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import Foundation
import UIKit

class LoginVC: BaseVC {
    
    static let name = "LoginVC"
    static let storyBoard = "Login"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> LoginVC {
        let vc = UIStoryboard(name: LoginVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: LoginVC.name) as! LoginVC
        return vc
    }
    
    // MARK: - IBOutlet Declaration
    
    
    @IBOutlet var loginVS: [UIView]!
    @IBOutlet var loginV: UIView!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    
    // MARK: - Override Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginV.setCornerRadius(radius: 8)
        loginVS.forEach({ $0.setCornerRadius(radius: 8, borderColor: UIColor.lightGray,borderWidth: 1)  })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTF.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func textFieldDidEndEditing() {
        emailTF.text = emailTF.text?.lowercased()  
    }
    
    /// It will validate and showing alert to users
    /// - Returns: Bool
    func validation() -> String? {
        if emailTF.text!.isEmpty  {
            return "Please enter your email address"
        } else if !Utils.isValidEmail(emailId: emailTF.text) {
            return "Please enter valid email address"
        } else if passwordTF.text!.isEmpty  {
            return "Please enter your password."
        } else if passwordTF.text!.count < 6  {
            return "password must be more than 6 character."
        }
        return nil
    }
    
    
    // MARK: - IBAction Methods
    
    @IBAction func actionOnBack() {
        let loginSignupBVC = LoginSignupVC.instantiateFromStoryboard()
        navigationController?.pushViewController(loginSignupBVC, animated: true)
    }
    
    @IBAction func actionOnLogin() {
        if let errorMessage = validation() {
            Utils.showAlert(message: errorMessage, viewController: self)
        } else {
            if let user = UserDao.fetchUserEmailId(emailId: emailTF.text ?? "") {
                if user.email == emailTF.text && user.password == passwordTF.text {
                    CustomUserDefaults.userId = user.id
                    CustomUserDefaults.name = user.userName
                    CustomUserDefaults.emailID = user.email
                    UserDao.saveOrUpdateUserLoginStatus(user: user, isLoggedIn: true)
                    let tabbarVC = ChatAppTabBarControllerVC.instantiateFromStoryboard()
                    navigationController?.pushViewController(tabbarVC, animated: true)
                } else {
                    Utils.showAlert(message: "Password is worng", viewController: self)
                }
            } else {
                Utils.showAlert(message: "No Account found!", viewController: self)
            }
            
        }
    }
    
    
    @IBAction func actionOnSignUp() {
        let signupVC = SignUpVC.instantiateFromStoryboard()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func actionOnForgot() {
        if emailTF.text!.isEmpty  {
            Utils.showAlert(message: "Please enter your email address", viewController: self)
        } else {
            let forgotVC = ForgotpasswordVC.instantiateFromStoryboard()
            forgotVC.emailText = emailTF.text ?? ""
            navigationController?.pushViewController(forgotVC, animated: true)
        }
    }
    
}



