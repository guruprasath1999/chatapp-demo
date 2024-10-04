//
//  BaseVC.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import Foundation
import UIKit
import SafariServices
import MBProgressHUD

class BaseVC: UIViewController {
    
    var enableDarkStatusBar = true
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return enableDarkStatusBar ? .darkContent : .lightContent
    }
    
    
    // MARK: - Override Function
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)  
    }
    
    // MARK: - OPEN LINK IN SAFARI WEBVIEW INSIDE APP

    func openSafariWebView(urlString: String) {
        if let url = URL(string: urlString) {
            let controller = SFSafariViewController(url: url)
            controller.preferredBarTintColor = UIColor.lightGray
            controller.preferredControlTintColor = UIColor.white
            controller.dismissButtonStyle = .done
            controller.configuration.barCollapsingEnabled = true
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
    func showLoader() {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Please wait..."
    }
    
    
    func stopLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    

    
    // MARK: - Navigation Bar Back Button

    func setNavigationBackBtn() {
        navigationController?.navigationBar.setNeedsLayout()
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(BaseVC.actionOnBackButton(sender:)))
        backBarBtn.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backBarBtn
    }
    
    @objc func actionOnBackButton(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ToolBar Methods

    func getToolBar(isDone: Bool = false) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.white
        toolBar.tintColor = UIColor.black

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems(isDone ? [] : [spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
    }

    @objc func donePressed() {
        view.endEditing(true)
    }
    
    //MARK:- ToolBar Methods
    func getToolBar(isShowCancelBtn: Bool = true, title: String = "") -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.barTintColor = UIColor.white
        toolBar.tintColor = UIColor.black
        let label = UILabel(frame: .zero)
        label.text = title
        label.textAlignment = .center
        label.textColor = .gray
        let titleBarButton = UIBarButtonItem(customView: label)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        if isShowCancelBtn {
            if title.isEmpty {
                toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            } else {
                toolBar.setItems([spaceButton, titleBarButton, spaceButton], animated: false)
            }
        } else {
            toolBar.setItems([spaceButton, doneButton], animated: false)
        }
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        return toolBar
    }
    
    @objc func cancelPressed() {
        view.endEditing(true)
    }
    
    
}


extension BaseVC: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

