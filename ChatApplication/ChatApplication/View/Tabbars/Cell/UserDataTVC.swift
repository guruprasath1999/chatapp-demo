//
//  UserDataTVC.swift
//  ChatApplication
//
//  Created by NAM on 04/10/24.
//

import UIKit
import SDWebImage

class UserDataTVC: UITableViewCell {
    
    @IBOutlet var nameL: UILabel!
    @IBOutlet var genderL: UILabel!
    @IBOutlet var ageL: UILabel!
    @IBOutlet var phoneNumberL: UILabel!
    @IBOutlet var emailL: UILabel!
    @IBOutlet var profileIV: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileIV.layer.masksToBounds = true
        profileIV.layer.cornerRadius = profileIV.bounds.width / 2
    }
    
    // ConfigureCell - It will show to the users pagination details
    /// - Parameter index: configureCell(index)
    func configureCell(user: UserModel) {
        nameL.text = "\(user.firstName) \(user.lastName)"
        genderL.text = user.gender
        ageL.text = "\(user.age)"
        phoneNumberL.text = user.phone
        emailL.text = user.email
        if let url = URL(string: user.image) {
            profileIV.setImage(url: url)
        }
        
        
    }

    
}
