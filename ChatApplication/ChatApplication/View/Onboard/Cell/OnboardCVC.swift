//
//  OnboardCVC.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import UIKit

class OnboardCVC: UICollectionViewCell {
    
    // MARK: IBOutlet Declarations
    
    @IBOutlet var onBoardTitleLbl: UILabel!
    @IBOutlet var onBoardSubTitleLbl: UILabel!
    @IBOutlet var onBoardIV: UIImageView!
    
    // MARK: Override Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    /// ConfigureCell - It will show to the users pagination details
    /// - Parameter index: configureCell(index)
    func configureCell(onboard: Onboard) {
        onBoardTitleLbl.text = onboard.title
        onBoardSubTitleLbl.text = onboard.subtitle
        onBoardIV.image = onboard.image
    }
}
