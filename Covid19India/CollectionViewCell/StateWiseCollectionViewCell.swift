//
//  StateWiseCollectionViewCell.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 25/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import UIKit

class StateWiseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stateNameLabel: CustomPaddedLabel!
    
    @IBOutlet weak var confirmedLabel: UILabel!
    
    @IBOutlet weak var confirmedCountLabel: UILabel!
    
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBOutlet weak var activeCountLabel: UILabel!
    
    @IBOutlet weak var recoveredLabel: UILabel!
    
    @IBOutlet weak var recoveredCountLabel: UILabel!
    
    @IBOutlet weak var deathsLabel: UILabel!
    
    @IBOutlet weak var deathsCountLabel: UILabel!
    
}
