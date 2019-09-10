//
//  AnimationView.swift
//  CardViewDemo
//
//  Created by Rumooz Technologies on 05/09/19.
//  Copyright © 2019 Rumooz Technologies. All rights reserved.
//

import UIKit

class AnimationView: UIViewController {

    @IBOutlet var Yconstraint:NSLayoutConstraint!
    @IBOutlet var Cardview:UIView!
    @IBOutlet var loader:UIActivityIndicatorView!
    @IBOutlet var SwipeLbl:UILabel!
    @IBOutlet var OfferLbl:UILabel!

    
    var timer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Cardview.shadow()
        loader.isHidden = true
        OfferLbl.isHidden = true
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector(respondToSwipeGesture))
            swipeGesture.direction = .down
        self.Cardview.addGestureRecognizer(swipeGesture)
        
        SwipeLbl.blink()
     
    }
  
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
          
            case UISwipeGestureRecognizer.Direction.down:
                UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseIn, animations: {
                    self.Yconstraint.constant = 600
                    self.view.layoutIfNeeded()
                    self.SwipeLbl.isHidden = true
                    self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.Timerresponse), userInfo: nil, repeats: false)

                    
                }) { (yes) in
                    if yes
                    {
                    UIView.animate(withDuration: 0.1, delay: 0.6, options: .curveEaseIn, animations: {
                        self.loader.isHidden = false
                        self.loader.startAnimating()
                    }, completion: nil)
                    }
                }
              
            default:
                break
            }
        }
    }
    
   @objc func Timerresponse()
    {
        resume()
        UIView.animate(withDuration: 1.0, delay: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.Cardview.alpha = 1.0
        }, completion: {
            (finished: Bool) -> Void in
            // Fade in
            
            self.perform(#selector(self.flip), with:nil, afterDelay: 0.8)
//            UIView.animate(withDuration: 1.0, delay: 1, options: UIView.AnimationOptions.curveEaseIn, animations: {
//                self.flip()
//            }, completion: nil)
        })
        self.timer.invalidate()
    }
    func resume()
    {
        self.Cardview.transform = CGAffineTransform (scaleX: 1, y: 1)

        self.loader.isHidden = true
        self.loader.stopAnimating()
        self.Cardview.alpha = 1.0
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseIn, animations: {
            self.Yconstraint.constant = 90
            self.view.layoutIfNeeded()
        }) { (yes) in
        }
    }
    
    @IBAction func Stop()
    {
        self.SwipeLbl.isHidden = false
        self.OfferLbl.isHidden = true

        resume()
    }
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: Cardview, duration: 1, options: transitionOptions, animations: {
            self.Cardview.alpha = 1.0
            self.Cardview.backgroundColor = .brown
            self.OfferLbl.isHidden = false
            self.OfferLbl.alpha = 1.0

        })
    }
      @objc func Zoomout() {
        
        UIView.animate(withDuration: 0.5) {
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.Cardview.transform = CGAffineTransform (scaleX: 0.1, y: 0.1)

        }) { (yeso) in
            self.Cardview.transform = CGAffineTransform (scaleX: 0.0, y: 0.0)

        }
    }
    
}
extension UILabel {
   
    func blink() {
        self.alpha = 0.1
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
    func LabelAnimation()
    {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 2.0,   delay: 0,usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,options: .allowUserInteraction,  animations:
            {
                self.transform = .identity
        },     completion: nil)
    }
}

