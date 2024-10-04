//
//  OnboardModel.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import Foundation
import UIKit

class Onboard {
    
    var title: String
    var subtitle: String
    var image: UIImage?
    
    init(title: String,subtitle: String, image: UIImage) {
        self.subtitle = subtitle
        self.title = title
        self.image = image
    }
}

struct ResponseBaseModel: Codable {
    var message: String
    var code: Int
}
