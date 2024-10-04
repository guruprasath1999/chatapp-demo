//
//  CustomUserDefaults.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import UIKit

let NAME = "NAME"
let EMAIL_ID = "EMAIL_ID"
let USER_ID = "USER_ID"

class CustomUserDefaults: NSObject {
    
    static var name: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: NAME)
        }
        get {
            UserDefaults.standard.value(forKey: NAME) as? String
        }
    }
    
    static var userId: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: USER_ID)
        }
        get {
            UserDefaults.standard.value(forKey: USER_ID) as? String
        }
    }
    
    static var emailID: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: EMAIL_ID)
        }
        get {
            UserDefaults.standard.value(forKey: EMAIL_ID) as? String
        }
    }
    
   
}

