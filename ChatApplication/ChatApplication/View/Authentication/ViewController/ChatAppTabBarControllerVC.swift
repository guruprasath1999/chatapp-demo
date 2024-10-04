//
//  ChatAppTabBarControllerVC.swift
//  ChatApplication
//
//  Created by NAM on 02/10/24.
//

import Foundation
import UIKit

class ChatAppTabBarControllerVC: UITabBarController {
    
    static let name = "ChatAppTabBarControllerVC"
    static let storyBoard = "ChatAppTabBarController"

    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> ChatAppTabBarControllerVC {
        let vc = UIStoryboard(name: ChatAppTabBarControllerVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: ChatAppTabBarControllerVC.name) as! ChatAppTabBarControllerVC
        return vc
    }

    // MARK: - Override Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupViews()
    }
}


extension ChatAppTabBarControllerVC {
    
    
    /// It will enhance to UI
    func setupViews() {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor.white
        createTabbarControllers()
        overrideUserInterfaceStyle = .light
        tabBar.clipsToBounds = true

        tabBar.layer.shadowColor = UIColor(hexStr: "D9D9D9").cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        tabBar.tintColor = UIColor(hexStr: "3D8A98")
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = false
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }

    
    private func createTabbarControllers() {
        
        let chatListVC = CustomNavigationController(rootViewController: ConversationVC.instantiateFromStoryboard())
        chatListVC.tabBarItem = UITabBarItem(title: "ChatList", image: UIImage(named:  "messageUnSelected"), tag: 1)
        chatListVC.tabBarItem.selectedImage = UIImage(named:  "messageSelected")
    
        let settingsVC = CustomNavigationController(rootViewController: SettingsVC.instantiateFromStoryboard())
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "profileUnSelected"), tag: 2)
        settingsVC.tabBarItem.selectedImage = UIImage(named:  "profileSelected")
        

        viewControllers = [chatListVC, settingsVC]
        selectedIndex = 0

    }
    
    
}


