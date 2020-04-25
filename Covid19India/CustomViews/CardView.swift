//
//  CardView.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 25/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}
