//
//  ForgotpasswordVC.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import UIKit

class ForgotpasswordVC: BaseVC {
    
    static let name = "ForgotpasswordVC"
    static let storyBoard = "Forgotpassword"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> ForgotpasswordVC {
        let vc = UIStoryboard(name: ForgotpasswordVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: ForgotpasswordVC.name) as! ForgotpasswordVC
        return vc
    }
    
    // MARK: - IBOutlet Declaration
    
    
    @IBOutlet var passwordVS: [UIView]!
    @IBOutlet var continueV: UIView!
    @IBOutlet var newPasswordTF: UITextField!
    @IBOutlet var confirmPasswordTF: UITextField!
    
    var emailText = ""
    
    
    // MARK: - Override Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueV.setCornerRadius(radius: 8)
        passwordVS.forEach({ $0.setCornerRadius(radius: 8, borderColor: UIColor.lightGray,borderWidth: 1)  })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// It will validate and showing alert to users
    /// - Returns: Bool
    func validation() -> String? {
        if newPasswordTF.text!.isEmpty  {
            return "Please enter new password."
        } else if confirmPasswordTF.text!.isEmpty  {
            return "Please enter your confirm password."
        } else if newPasswordTF.text!.count < 6  {
            return "New password must be more than 6 character."
        } else if confirmPasswordTF.text!.count < 6  {
            return "Confirm password must be more than 6 character."
        } else if  newPasswordTF.text != confirmPasswordTF.text  {
            return "Confirm password and New password are not same, Please check and enter again!"
        }
        return nil
    }
    
    
    // MARK: - IBAction Methods
    
    @IBAction func actionOnBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionOnContinue() {
        if let errorMessage = validation() {
            Utils.showAlert(message: errorMessage, viewController: self)
        } else {
            view.endEditing(true)
            Utils.showHUD(view: view)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [self] timer in
                if let user = UserDao.fetchUserEmailId(emailId: emailText) {
                    Utils.hideHUD(view: self.view)
                    UserDao.saveOrUpdateUserLoginPassword(user: user, password: confirmPasswordTF.text ?? "")
                    
                    
                    Utils.showAlertWithCompletion(withTitle: "success!", message: "Password have been upadated successfully", on: self) {
                        let loginVC = LoginVC.instantiateFromStoryboard()
                        self.navigationController?.pushViewController(loginVC, animated: true)
                    }
                } else {
                    Utils.showAlert(message: "No Account found!", viewController: self)
                    
                }
                
            }
        }
    }
    
}




