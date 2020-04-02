//
//  StateWiseCell.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 01/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import UIKit

class StateWiseCell: UITableViewCell {

    @IBOutlet weak var stateNameLabel: UILabel!
    
    func setData(stateWiseDateModel:StateWiseModel) {
        stateNameLabel.text = stateWiseDateModel.state
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
