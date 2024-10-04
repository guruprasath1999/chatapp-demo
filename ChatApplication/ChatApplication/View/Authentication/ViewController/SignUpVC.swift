//
//  SignUpVC.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import UIKit


class SignUpVC: BaseVC {
    
    static let name = "SignUpVC"
    static let storyBoard = "SignUp"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> SignUpVC {
        let vc = UIStoryboard(name: SignUpVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: SignUpVC.name) as! SignUpVC
        return vc
    }
    
    // MARK: - IBOutlet Declaration
    
    
    @IBOutlet var signupVS: [UIView]!
    @IBOutlet var signupV: UIView!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    
    // MARK: - Override Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupV.setCornerRadius(radius: 8)
        signupVS.forEach({ $0.setCornerRadius(radius: 8, borderColor: UIColor.lightGray,borderWidth: 1)  })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTF.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func textFieldDidEndEditing() {
        emailTF.text = emailTF.text?.lowercased()
       }
    
    /// It will validate and showing alert to users
    /// - Returns: Bool
    func validation() -> String? {
        if nameTF.text!.isEmpty  {
            return "Please enter your name."
        }  else  if emailTF.text!.isEmpty  {
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionOnSignUp() {
        if let errorMessage = validation() {
            Utils.showAlert(message: errorMessage, viewController: self)
        } else {
            view.endEditing(true)
            Utils.showHUD(view: view)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [self] timer in
                if UserDao.fetchUserEmailId(emailId: emailTF.text ?? "") != nil {
                    Utils.hideHUD(view: self.view)
                    Utils.showAlert(message: "Email id is present already Please some other email to login", viewController: self)
                } else {
                    saveUserData()
                }
                
                }
            
        }
    }
    
    @IBAction func actionOnLogin() {
        let loginVC = LoginVC.instantiateFromStoryboard()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func saveUserData() {
        Utils.hideHUD(view: self.view)
        let userObject = RealmUser(id: UUID().uuidString, email: emailTF.text, userName: nameTF.text, password: passwordTF.text, isUserLoggedIn: true)
        UserDao.createUser(user: userObject)
        
        Utils.showAlertWithCompletion(withTitle: "Registration Successful!", message: "The account has been registered successfully. Please log-in using your credentials.", on: self) {
            let loginVC = LoginVC.instantiateFromStoryboard()
                self.navigationController?.pushViewController(loginVC, animated: true)
        }

        
      
    }
    
    
}



