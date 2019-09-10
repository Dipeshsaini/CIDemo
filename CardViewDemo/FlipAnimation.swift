//
//  FlipAnimation.swift
//  CardViewDemo
//
//  Created by Rumooz Technologies on 06/09/19.
//  Copyright © 2019 Rumooz Technologies. All rights reserved.
//

import UIKit

class FlipAnimation: UIViewController {

   @IBOutlet var firstView: UIView!
   @IBOutlet var offerLabel: UILabel!

    var valueflip =  true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.offerLabel.isHidden = true
        firstView.shadow()

        let tap = UITapGestureRecognizer (target: self, action: #selector(flip))
        firstView.addGestureRecognizer(tap)
        
    }
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            
            if self.valueflip == true
            {
                self.offerLabel.isHidden = false
                self.firstView.backgroundColor = .cyan
                self.valueflip = false
            }else
            {
                self.offerLabel.isHidden = true
                self.firstView.backgroundColor = .brown
                self.valueflip = true
            }
        })
        
        
    }


}
