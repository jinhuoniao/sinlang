//
//  PlayerController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class PlayerController: UIViewController {

    var liveUrl = ""
    var imageUrl = ""
    var dimImage = UIImageView.init(frame: UIScreen.mainScreen().bounds)
    var player = IJKFFMoviePlayerController()
    var playerView = UIView.init(frame: UIScreen.mainScreen().bounds)
    var number = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.goPlaying()
        self.installMovieNotificationObservses()
        self.setupLoadingView()
        self.setupBtn()
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        self.player.stop()
    }
    
    override func viewDidAppear(animated: Bool) {
        if !self.player.isPlaying() {
            self.player.prepareToPlay()
        }
    }
    
    func setupLoadingView() {
        self.dimImage.sd_setImageWithURL(NSURL.init(string: String.init(format: "http://img.meelive.cn/%@", self.imageUrl)))
        let blurEffect = UIBlurEffect.init(style: .Light)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = self.dimImage.bounds;
        dimImage.addSubview(visualEffectView)
        self.view.addSubview(self.dimImage)
    }
    
    func setupBtn() {
        let backBtn = UIButton.init(type: .Custom)
        backBtn.frame = CGRectMake(10, 64 / 2 - 8, 33, 33)
        backBtn.setImage(UIImage.init(named: "goback"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(self.goBack), forControlEvents: .TouchUpInside)
        backBtn.layer.shadowColor = UIColor.blackColor().CGColor
        backBtn.layer.shadowOffset = CGSizeMake(0, 0)
        backBtn.layer.shadowOpacity = 0.5
        backBtn.layer.shadowRadius = 1
        self.view.addSubview(backBtn)
        
        let playBtn = UIButton.init(type: .Custom)
        playBtn.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 33 - 10, 64 / 2 - 8, 33, 33)
        if self.number == 0 {
            playBtn.setImage(UIImage.init(named: "play"), forState: .Normal)
            playBtn.setImage(UIImage.init(named: "开始"), forState: .Selected)
        } else {
            playBtn.setImage(UIImage.init(named: "开始"), forState: .Normal)
            playBtn.setImage(UIImage.init(named: "play"), forState: .Selected)
        }
        playBtn.layer.shadowColor = UIColor.blackColor().CGColor
        playBtn.layer.shadowOffset = CGSizeMake(0, 0)
        playBtn.layer.shadowOpacity = 0.5
        playBtn.layer.shadowRadius = 1
        self.view.addSubview(playBtn)
        
        let btnWH:CGFloat = 36
        let margin:CGFloat = 20
        let btnY = UIScreen.mainScreen().bounds.height - 36 - 10
        let linesW = (UIScreen.mainScreen().bounds.width - btnWH - margin * 2) / 3
        let images = ["normalMsg","privateMsg","web_chat_timeline_share_normal","empty"]
        for i in 0...3 {
            let heartBtn = UIButton.init(type: .Custom)
            heartBtn.frame = CGRectMake(margin + linesW * CGFloat(i), btnY, btnWH, btnWH)
            heartBtn.setImage(UIImage.init(named: images[i]), forState: .Normal)
            heartBtn.layer.shadowColor = UIColor.blackColor().CGColor
            heartBtn.layer.shadowOffset = CGSizeMake(0, 0)
            heartBtn.layer.shadowOpacity = 0.5
            heartBtn.layer.shadowRadius = 1
            heartBtn.adjustsImageWhenHighlighted = false;
            [self.view.addSubview(heartBtn)]
        }
        
    }
    
    func goPlaying() {
        let url = NSURL.init(string: self.liveUrl)
        self.player = IJKFFMoviePlayerController.init(contentURL: url!, withOptions: nil)
        let pView = self.player.view
        let displayView = UIView.init(frame: self.view.bounds)
        self.playerView = displayView
        self.playerView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.playerView)
        
        pView.frame = self.playerView.bounds
        pView.autoresizingMask = .FlexibleWidth
        pView.autoresizingMask = .FlexibleHeight
        self.playerView.insertSubview(pView, atIndex: 1)
        player.scalingMode = .AspectFill
        player.play()
    }
    
    func installMovieNotificationObservses() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.moviePlayBackStateDidChange), name: IJKMPMoviePlayerPlaybackStateDidChangeNotification, object: self.player)
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(self.rote), userInfo: nil, repeats: true)
    }
    
    func moviePlayBackStateDidChange() {
        self.dimImage.hidden = true
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:   button点击事件
    func goBack() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func rote() {
        let heartSize:CGFloat = 35
        let heart = DMHeartFlyView.init(frame: CGRectMake(0, 0, 50, 50))
        self.view.addSubview(heart)
        let fountainSource = CGPointMake(UIScreen.mainScreen().bounds.width - heartSize, UIScreen.mainScreen().bounds.height - heartSize / 2 - 10)
        heart.center = fountainSource
        heart.animateInView(self.view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     
     //        self.player = IJKFFMoviePlayerController.init(contentURL: NSURL.init(string: self.liveUrl)!, withOptions: nil)
     //        self.player.scalingMode = .Fill
     //        player.view.backgroundColor = UIColor.blueColor()
     //        self.view.addSubview(self.player.view)
     //        self.player.prepareToPlay()
     //        self.player.play()
    */

}
