//
//  PopupViewController.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 02/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var confirmedLable: UILabel!
    
    @IBOutlet weak var confirmedValueLabel: UILabel!
    
    @IBOutlet weak var recoveredLabel: UILabel!
    
    @IBOutlet weak var recoveredValueLabel: UILabel!
    
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBOutlet weak var activeValueLabel: UILabel!
    
    @IBOutlet weak var deathsLebel: UILabel!
    
    @IBOutlet weak var deathsValueLabel: UILabel!
    
    @IBAction func onCloseTapped(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    var mStateWiseData:StateWiseModel?
    
    
    func setData(stateWiseData:StateWiseModel) {
        self.mStateWiseData = stateWiseData
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        activeLabel.text = "ACTIVE"
        activeValueLabel.text = mStateWiseData?.active
        confirmedLable.text = "CONFIRMED"
        confirmedValueLabel.text = mStateWiseData?.confirmed
        recoveredLabel.text = "RECOVERED"
        recoveredValueLabel.text = mStateWiseData?.recovered
        deathsLebel.text = "DEATHS"
        deathsValueLabel.text = mStateWiseData?.deaths
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
