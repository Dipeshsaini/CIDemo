//
//  ViewExtension.swift
//  CardViewDemo
//
//  Created by Rumooz Technologies on 05/09/19.
//  Copyright © 2019 Rumooz Technologies. All rights reserved.
//

import Foundation
import Foundation
import UIKit


var associateObjectValue: Int = 0

//MARK:-  UIView cornerRadius
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
    
    
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            // layer.masksToBounds = true
            layer.cornerRadius = newValue
            
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
   
    
    
}

extension UITextField {
    @IBInspectable var LeftImage: UIImage? {
        get{
            return self.LeftImage
        }
        set{
            let containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width:30, height: self.frame.height))
            let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = newValue
            containerView.addSubview(imageView)
            imageView.center = containerView.center
            self.leftView = containerView
            self.leftViewMode = UITextField.ViewMode.always
        }
    }
    @IBInspectable var RightImage: UIImage? {
        get{
            return self.RightImage
        }
        set{
            let containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width:30, height: self.frame.height))
            let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = newValue
            containerView.addSubview(imageView)
            imageView.center = containerView.center
            self.rightView = containerView
            self.rightViewMode = UITextField.ViewMode.always
        }
    }
    
}
extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: size.width/8, y: size.height - lineWidth, width: 3*size.width/4, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.2
        animation.values = [-10.0, 10.0, -10.0, 10.0, -70.0, 70.0, -3.0, 3.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    func shadow()
    {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width:5, height: 5);
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 25.0
    }
    
}
