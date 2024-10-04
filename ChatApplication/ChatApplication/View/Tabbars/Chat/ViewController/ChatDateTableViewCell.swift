//
//  Untitled.swift
//  ChatApplication
//
//  Created by NAM on 03/10/24.
//

import UIKit

class ChatDateTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.setCornerRadius(radius: 10)
        transform = CGAffineTransform(scaleX: 1, y: -1)
    }
}
