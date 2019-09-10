//
//  ViewController.swift
//  CardViewDemo
//
//  Created by Rumooz Technologies on 05/09/19.
//  Copyright © 2019 Rumooz Technologies. All rights reserved.
//

import UIKit
import FSPagerView
import AVKit
import AVFoundation

class ViewController: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate{
   
    

    @IBOutlet var collectionView:UICollectionView!
    
    var aview:UIView!
    var aviewFrame:CGRect!
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    
    let widthcollection =  UIScreen.main.bounds.width
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
            self.pagerView.decelerationDistance = FSPagerView.automaticDistance
             pagerView.transformer = FSPagerViewTransformer(type: .linear)
            
        }
    }
    
    // MARK:- FSPagerViewDataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.backgroundColor = .orange
        cell.imageView?.layer.cornerRadius = 10

        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        
        let tabBar = self.tabBarController?.tabBar
        tabBar?.selectionIndicatorImage = UIImage().createSelectionIndicator(color: .orange, size: CGSize(width: (tabBar?.frame.width)!/4, height:(tabBar?.frame.height)! ), lineWidth: 5.0)
        
        Video_Player_Method()
        
    }
    func Video_Player_Method()
    {
        
        aview = UIView (frame: CGRect (x:100, y: 500, width: 200, height: 200))
        aview.backgroundColor = UIColor.white
        self.view.addSubview(aview)
        
        //self.ShadowView_Without_Cornor_radius(ShadowView: aview)
        aview.layer.masksToBounds = false
        aview.layer.shadowColor = UIColor.black.cgColor
        aview.layer.shadowOffset = CGSize(width:0, height: 2);
        aview.layer.shadowOpacity = 0.3
        aview.layer.shadowRadius = 5.0
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = aview.bounds
        aview.layer.addSublayer(playerLayer)
        player.pause()
        aviewFrame = aview.frame
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        Add_PanGesture()
        Add_PlayvideoGesture()
        Add_DoubleTapGesture()
    }
    
    func Add_PanGesture()
    {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(_:)))
        aview.addGestureRecognizer(gesture)
    }
    func Add_PlayvideoGesture()
    {
        let playbtntap = UITapGestureRecognizer(target: self, action: #selector(Playvideo))
        aview.addGestureRecognizer(playbtntap)
    }
    func Add_DoubleTapGesture()
    {
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(EnlargeTheview(_:)))
        doubletap.numberOfTapsRequired = 2
        aview.addGestureRecognizer(doubletap)
    }
    
    @objc func wasDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.view)
        
        if  gestureRecognizer.view!.frame.origin.x < 0
        {
            gestureRecognizer.view!.center = CGPoint(x: self.view.frame.size.width/4, y: gestureRecognizer.view!.center.y + translation.y)
        }
        else if gestureRecognizer.view!.frame.origin.y < 30
        {
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: 130)
        }
        else if gestureRecognizer.view!.frame.origin.x > self.view.frame.size.width - 200
        {
            gestureRecognizer.view!.center = CGPoint(x: self.view.frame.size.width - 110, y: gestureRecognizer.view!.center.y + translation.y)
        }
        else if gestureRecognizer.view!.frame.origin.y > self.view.frame.size.height - 200
        {
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: self.view.frame.size.height - 110)
        }
        else
        {
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
        }
        gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        
        self.aviewFrame = gestureRecognizer.view!.frame
        print("aviewFrame",aviewFrame as Any)
        
    }
    @objc func Playvideo()
    {
        if player.timeControlStatus == .paused
        {
            player.play()
        }
        else if player.timeControlStatus == .playing
        {
            player.pause()
        }
    }
    @objc  func playerItemDidPlayToEnd(_ notification: Notification) {
        // Your Code.
        player.seek(to:CMTime.zero)
        player.play()
    }
    @objc func EnlargeTheview(_ sender: UITapGestureRecognizer)
    {
        if sender.view?.frame.height != self.view.frame.height
        {
            UIView.animate(withDuration: 0.1)
            {
                self.aview.gestureRecognizers?.removeAll()
                
                self.Add_PlayvideoGesture()
                self.Add_DoubleTapGesture()
                
                self.aview.backgroundColor = UIColor.black
                
                self.aview.frame = CGRect (x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                UIView.animate(withDuration: 0.9)
                {
                    self.playerLayer.frame = self.view.bounds
                }
            }
        }
        else
        {
            UIView.animate(withDuration: 0.1)
            {
                self.aview.backgroundColor = UIColor.white
                
                self.Add_PlayvideoGesture()
                self.Add_PanGesture()
                self.Add_DoubleTapGesture()
                self.aview.frame = self.aviewFrame
                UIView.animate(withDuration: 0.9)
                {
                    self.playerLayer.frame =  self.aview.bounds
                }
            }
        }
        
        Playvideo()
    }
}
