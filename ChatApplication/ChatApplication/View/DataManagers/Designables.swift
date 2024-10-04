//
//  Designables.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import UIKit

@IBDesignable class ATShadowView: UIView {
    @IBInspectable var shadowCornerRadius : CGFloat = 0

    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0 {
        didSet {
            update()
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            update()
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = .black {
        didSet {
            update()
        }
    }
    override var frame: CGRect {
        didSet(oldFrame) {
            if oldFrame.size != frame.size {
                update()
            }
        }
    }
    
    override var bounds: CGRect {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        isOpaque = true
        layer.shouldRasterize = true
    }
    
    private func update() {
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadowCornerRadius).cgPath
    }
}

