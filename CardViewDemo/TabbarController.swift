//
//  TabbarController.swift
//  CardViewDemo
//
//  Created by Rumooz Technologies on 06/09/19.
//  Copyright © 2019 Rumooz Technologies. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController,UITabBarControllerDelegate {

    var secondItemImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        let secondItemView = self.tabBar.subviews[1]
        self.secondItemImageView = (secondItemView.subviews.first as! UIImageView)
        self.secondItemImageView.contentMode = .center
        
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let index = self.tabBar.items?.firstIndex(of: item)
        let subView = tabBar.subviews[index!+1].subviews[1] as! UIImageView
        self.performSpringAnimation(imgView: subView)
    }
    
    //func to perform spring animation on imageview
    func performSpringAnimation(imgView: UIImageView)
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            imgView.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { (flag) in
            }
        }) { (flag) in
            
        }
    }
    
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//       print(tabBar.tag,item.tag)
//        print("selectedIndex",selectedIndex)
//
//        if self.selectedIndex == 3
//        {
//            let a1 = self.tabBar.subviews[3]
//             a1.shake()
//        }else if self.selectedIndex == 1
//        {
//            self.secondItemImageView.transform = CGAffineTransform.identity
//            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
//
//                let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
//                self.secondItemImageView.transform = rotation
//
//            }, completion: nil)
//        }
//    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
        
        
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
