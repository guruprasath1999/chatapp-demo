//
//  Uiview + Extension.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import UIKit

extension UIView {
    
    func roundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func roundedView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2.0
    }
    
    func setCornerRadius(radius: CGFloat, borderColor: UIColor = #colorLiteral(red: 0.5019607843, green: 0.5843137255, blue: 0.7176470588, alpha: 1), borderWidth: CGFloat = 0.0) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    func setCornerRadiusWithoutMask(radius: CGFloat, borderColor: UIColor = #colorLiteral(red: 0.5019607843, green: 0.5843137255, blue: 0.7176470588, alpha: 1), borderWidth: CGFloat = 0.0) {
        layer.cornerRadius = radius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    func dropButtonShadow(scale: Bool = true,radius: Int = 8) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.cornerRadius = CGFloat(radius)
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    func addShadow(radius: Int = 15) {
        self.layer.shadowColor = UIColor(hexStr: "CFCFCF").cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = CGFloat(radius)
    }
}

extension UIColor {
    
    convenience init(hexStr: String) {
        var str = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (str.hasPrefix("#")) {
            str = (str as NSString).substring(from: 1)
        }
        
        if (str.count != 6) {
            self.init(white: 0.5, alpha: 1)
            return
        }
        
        let rString = (str as NSString).substring(to: 2)
        let gString = ((str as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((str as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    static var ratingDarkColor: UIColor? { return UIColor(named: "RatingDarkColor") }
    static var ratingGreenColor: UIColor? { return UIColor(named: "Primary color") }
    static var secondaryTextColor: UIColor? { return UIColor(named: "Secondary Text") }
    static var resultTVBorderColor: UIColor? { return UIColor(named: "resultTV_BorderColor") }
    static var cellbackgroundColor: UIColor? { return UIColor(named: "SelectCell") }
    static var detailsBorderColor: UIColor? { return UIColor(named: "details_BorderColor") }
    static var rightBarButtonColor: UIColor? { return UIColor(named: "right_BarButton_Color") }
    /*================================================================================================================*/
    
    static var prescriptionCellBordercolor: UIColor? { return UIColor(named: "Prescription_Cell_bordercolor") }
    
    
}

class DateUtils {
    class func convertToDate(dateString: String?, format: DateFormate, timeZone: TimeZone = TimeZone(abbreviation: "UTC")!) -> Date? {
        guard let dateString = dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: dateString)
    }
}

extension String {
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getDateFromServerString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func getFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            let currentDate = Date()
            let calendar = Calendar.current
            if calendar.isDate(date, inSameDayAs: currentDate) {
                return "Today"
            } else {
                dateFormatter.dateFormat = "dd MMMM yyyy"
                let formattedDate = dateFormatter.string(from: date)
                return formattedDate
            }
        } else {
            return ""
        }

    }
}


extension UILabel {
    
    var actualNumberOfLines: Int {
           guard let text = self.text else {
               return 0
           }
           layoutIfNeeded()
           let rect = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
           let labelSize = text.boundingRect(
               with: rect,
               options: .usesLineFragmentOrigin,
               attributes: [NSAttributedString.Key.font: font as Any],
               context: nil)
           return Int(ceil(CGFloat(labelSize.height) / font.lineHeight))
       }
}
