//
//  Utils.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import UIKit
import MBProgressHUD
import Photos


class Utils: NSObject {
    
    
    static var imageCache = [URL: UIImage]()
    
    // MARK: Set Root Controller
    
    class func setRootController(rootVCType: RootVCType) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        switch rootVCType {
        case .onboardVC:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: OnboardVC.instantiateFromStoryboard())
        case .splashVC:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: SplashVC.instantiateFromStoryboard())
            
        case .tabbarVC:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: ChatAppTabBarControllerVC.instantiateFromStoryboard())
        case .loginVC:
            UIApplication.shared.windows.first?.rootViewController = CustomNavigationController(rootViewController: LoginSignupVC.instantiateFromStoryboard())
        }
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    // MARK: - Authentication Validations
    
    class func isValidEmail(emailId: String?) -> Bool {
        guard let emailId = emailId, !emailId.contains("..") else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailId)
    }
    
    /// - Parameter password: Password (String)
    /// - Returns: Returns **true** if password validation success else it will return **false**
    class func isValidPassword(password: String) -> Bool {
        let res = Utils.validatePassword(password: password)
        return res.minChar && res.lowerCase && res.upperCase && res.specialChars
    }
    
    /// - Check password validations for minimum requirements (Regex)
    /// - Parameter password: Password (String)
    /// - Returns: Returns a tuple of Bool's
    class func validatePassword(password: String) -> (minChar: Bool, upperCase: Bool, lowerCase: Bool, specialChars: Bool) {
        // At least 8 characters
        let minChar = password.count >= 12
        
        // At least 1 upper case letter (A-Z)
        var passwordRegEx = "(.*[A-Z]+.*)"
        var passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let upperCase = passwordPredicate.evaluate(with: password)
        
        // At least 1 lower case letter (a-z)
        passwordRegEx = "(.*[a-z]+.*)"
        passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let lowerCase = passwordPredicate.evaluate(with: password)
        
        // At least 1 number OR 1 special character (.*[0-9]+.*)|(.*[!&^%$*#@()/]+.*)
        passwordRegEx = "(.*[0-9]+.*)|(.*[!&^%$*#@()/]+.*)"
        passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let specialChars = passwordPredicate.evaluate(with: password)
        return (minChar, upperCase, lowerCase, specialChars)
        
    }
    
    class func DateTimeString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm a, MMM dd yyyy" // Use "HH" for 24-hour format
            dateFormatter.timeZone = TimeZone.current // Set the time zone to the current local time zone
            dateFormatter.locale = Locale(identifier: "en_IN")
            
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date Format"
        }
    }
    
    
    // MARK: - Get Thumbnail Image Of Video From URL
    
    class func getThumbnailImage(forUrl url: URL) -> UIImage? {
        if let cachedImage = Utils.imageCache[url] { return cachedImage }
        
        do {
            let asset = AVURLAsset(url: url, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            // Utils.imageCache[url] = thumbnail
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
   
    
    // MARK: - Show Normal Alert message

    
    class  func showAlertWithCompletion(withTitle title: String, message: String, on viewController: UIViewController, completion: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            completion()
        }
        
        alertController.addAction(okayAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

    
    class func showAlert(title: String = "", message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    
    class func showAlertAndPopVC(title: String = "", message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { _ in
            viewController.dismiss(animated: true) {
                viewController.navigationController?.popViewController(animated: true)
            }
            
        }
        alertController.addAction(OKAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Set Timer Count Minutes And Seconds
    class func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: Set Stop Timer Counting
    class func endTimer(timer: Timer) {
        timer.invalidate()
    }
    
    // MARK: - Show & Hide HUD
    
    class func showHUD(view: UIView, isShow: Bool = true) {
        guard isShow else { return }
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = ""
    }
    
    class func hideHUD(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    /*================================================================================================================*/
    
    // MARK:- Show & Hide HUD
    class func showChatGPTHUD(view: UIView, isShow: Bool = true) {
        guard isShow else { return }
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.numberOfLines = 0
        loadingNotification.label.text = "Fetching Data... Please wait."
    }
    
    class func getAssetRealImage(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize.zero, contentMode: .aspectFit, options: option, resultHandler: { (result, _) -> Void in
            thumbnail = result ?? UIImage()
        })
        return thumbnail
    }
    
    
    class func makePhoneCall(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(phoneCallURL) {
            UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        } else {
            print("Your device does not support phone calls or the URL is invalid.")
        }
    }
    
    class func openWeb(webURL: String) {
        if let url = URL(string: webURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}


