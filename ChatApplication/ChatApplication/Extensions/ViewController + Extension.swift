//
//  ViewController + Extension.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width - 225)/2, y: self.view.frame.size.height-100, width: 225, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func setUpLargeTitle(title: String) {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode =  .always
    }
    
    func setUpSmallTitle(title: String) {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension Date {
    
    func addDay(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: n, to: self)!
    }
    
    func getStringBasedOn(format: DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    func getChatTime() -> String {
        if NSCalendar.current.isDateInToday(self) {
            return getLocalStringBasedOn(format: .chatTimeFormate)
        } else if NSCalendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return getLocalStringBasedOn(format: .secondaryNormalWithTime)
        }
    }
    
    func getLocalStringBasedOn(format: DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    
    func getUTCStringBasedOn(format: DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}
