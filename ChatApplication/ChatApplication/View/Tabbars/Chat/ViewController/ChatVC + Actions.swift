//
//  ChatVC + Actions.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import Foundation
import UIKit

extension ChatVC {
    
    // MARK: - IBAction Methods
    
    @IBAction func actionOnAddAsserts(sender: UIButton) {
        textView.resignFirstResponder()
        let alert = UIAlertController(title: "", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { _ in
            self.showImagePickerForCaptureImage()
        }))
        
        alert.addAction(UIAlertAction(title: "Video", style: UIAlertAction.Style.default, handler: { _ in
            self.showImagePickerForCaptureVideo()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default, handler: { _ in
            self.showImagePickerForChooseExistingImage()
        }))
        
        alert.addAction(UIAlertAction(title: "Video Library", style: UIAlertAction.Style.default, handler: { _ in
            self.showImagePickerForChooseExistingVideo()
        }))
        
        alert.addAction(UIAlertAction(title: "Files", style: UIAlertAction.Style.default, handler: { _ in
            self.showDocumentPicker()
        }))
        
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = tableView
            popoverPresentationController.sourceRect = tableView.bounds
        }
        alert.popoverPresentationController?.sourceView = actionSheetB
        alert.popoverPresentationController?.sourceRect = sender.frame
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionOnSendMessage() {
        if !textView.text.isEmpty {
            dataViewModel.sendMessage(messageType: .TEXT, text: textView.text,tempId: "")
            textView.text = ""
        }
        
    }
    
    @IBAction func actionOnBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // Function to handle keyboard showing
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardSize.height
            if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
                if #available(iOS 11, *) {
                    if keyboardHeight > 0 {
                        keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                    } else {
                    }
                }
                textViewBottomConstraint.constant = keyboardHeight + 8
                
            } else {
                textViewBottomConstraint.constant = 8
            }
            view.layoutIfNeeded()
        }
    }

    // Function to handle keyboard hiding
    @objc func keyboardWillHide(notification: NSNotification) {
        textViewBottomConstraint.constant = 8
    }
}
