//
//  CustomPaddedLabel.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 25/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import UIKit

@IBDesignable class CustomPaddedLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 10.0
    @IBInspectable var bottomInset: CGFloat = 10.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
}
