//
//  MusicTabBar.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit



let musicBar = MusicTabBar()

class MusicTabBar: UITabBar {

    static var shareMusicBar = {
        return musicBar
    }
    let tabView = UIView()
    let iconImage = UIImageView()
    let slider = UISlider.init(frame: CGRectMake(0, 0, 0, 10))
    let songNameL = UILabel()
    let singerNameL = UILabel()
    
    let playBtn = UIButton.init(type: .Custom)
    let upBtn = UIButton.init(type: .Custom)
    let nextBtn = UIButton.init(type: .Custom)
    let menuListBtn = UIButton.init(type: .Custom)
    var timer = NSTimer.init()
    var songIdArray = NSArray()
    var currentIndex = 0
    var isPlay: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
        self.userInteractionEnabled = true
        tabView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tap))
        tabView.addGestureRecognizer(tap)
    }
    
    func tap() {
        if self.songNameL.text != nil {
            NSNotificationCenter.defaultCenter().postNotificationName("toPlayMusicController", object: nil)
        } else {
            MyPromptTool.promptModeText("当前没有歌曲", afterDelay: 1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
        self.addSubview(tabView)
        self.tabView.addSubview(iconImage)
        self.tabView.addSubview(slider)
        self.tabView.addSubview(songNameL)
        self.tabView.addSubview(singerNameL)
        self.tabView.addSubview(menuListBtn)
        self.tabView.addSubview(nextBtn)
        self.tabView.addSubview(playBtn)
        self.tabView.addSubview(upBtn)
        
        slider.userInteractionEnabled = true
        slider.setThumbImage(UIImage.init(named: "thumb"), forState: .Normal)
        slider.addTarget(self, action: #selector(self.sliderValueChange), forControlEvents: .TouchUpInside)
        
        songNameL.font = UIFont.boldSystemFontOfSize(20)
        songNameL.textColor = UIColor.blackColor()
        
        singerNameL.font = UIFont.boldSystemFontOfSize(18)
        singerNameL.textColor = UIColor.grayColor()
        
        iconImage.image = UIImage.init(named: "icon")
        menuListBtn.setImage(UIImage.init(named: "icon_ios_list"), forState: .Normal)
        nextBtn.setImage(UIImage.init(named: "icon_ios_music_forward"), forState: .Normal)
        nextBtn.addTarget(self, action: #selector(self.nextBtnClick), forControlEvents: .TouchUpInside)
        playBtn.setImage(UIImage.init(named: "icon_ios_music_play"), forState: .Normal)
        playBtn.addTarget(self, action: #selector(self.playBtnClick), forControlEvents: .TouchUpInside)
        upBtn.setImage(UIImage.init(named: "icon_ios_music_backward"), forState: .Normal)
        upBtn.addTarget(self, action: #selector(self.upBtnClick), forControlEvents: .TouchUpInside)
        
        
        tabView.sd_layout().leftEqualToView(self).topEqualToView(self).rightEqualToView(self).bottomEqualToView(self)
        iconImage.sd_layout().leftEqualToView(self.tabView).bottomEqualToView(self.tabView).widthIs(60).heightIs(60)
        iconImage.sd_cornerRadius = 30
        slider.sd_layout().leftSpaceToView(self.iconImage, aSpace).topSpaceToView(self.tabView, -5).rightSpaceToView(self.tabView, aSpace)
        songNameL.sd_layout().leftSpaceToView(self.iconImage, aSpace).bottomSpaceToView(self.singerNameL, 0).heightIs(20).widthIs(150)
        singerNameL.sd_layout().leftSpaceToView(self.iconImage, aSpace).bottomSpaceToView(self.tabView, 0).widthIs(150).heightIs(15)
        
        menuListBtn.sd_layout().rightSpaceToView(self.tabView, 2).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        nextBtn.sd_layout().rightSpaceToView(self.menuListBtn, bSpace).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        playBtn.sd_layout().rightSpaceToView(self.nextBtn, bSpace).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        upBtn.sd_layout().rightSpaceToView(self.playBtn,bSpace).bottomSpaceToView(self.tabView, 0).widthIs(30).heightIs(30)
        
        menuListBtn.addTarget(self, action: #selector(self.tap), forControlEvents: .TouchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for tabBarButton in self.subviews {
            if "\(tabBarButton.classForCoder)" != "UITabBarButton" {
                continue
            }
            tabBarButton.userInteractionEnabled = false
        }
    }
    
    func setContent(model: PlaySongModel, songIdArray: NSMutableArray, currentIndex: NSInteger) {
        self.songNameL.text = model.songName
        self.singerNameL.text = model.artistName
        self.iconImage.sd_setImageWithURL(NSURL.init(string: model.songPicSmall))
        self.isPlay = true
        self.playBtn.setImage(UIImage.init(named: "icon_ios_music_pause"), forState: .Normal)
        self.slider.value = 0
        self.songIdArray = songIdArray
        self.currentIndex = currentIndex
        
        
        
    }
    
    //MARK:  button点击事件
    func playBtnClick() {
        
        let playMusic = PlayingMusicController.sharePlay
        self.isPlay = !self.isPlay
        if self.isPlay == true {
            if self.songNameL.text == nil {
                self.playBtn.setImage(UIImage.init(named: "icon_ios_music_play"), forState: .Normal)
                self.isPlay = false
                MyPromptTool.promptModeText("当前没有歌曲", afterDelay: 1)
            } else {
                self.playBtn.setImage(UIImage.init(named: "icon_ios_music_pause"), forState: .Normal)
                playMusic.player.play()
                playMusic.isPlaying = true
                playMusic.playBtn.setImage(UIImage.init(named: "icon_ios_music_pause"), forState: .Normal)
            }
        } else {
            self.playBtn.setImage(UIImage.init(named: "icon_ios_music_play"), forState: .Normal)
            playMusic.player.pause()
            playMusic.isPlaying = false
            playMusic.playBtn.setImage(UIImage.init(named: "icon_ios_music_play"), forState: .Normal)
        }
    }
    
    func sliderValueChange() {
        if self.songNameL.text == nil {
            return
        } else {
            let playMusic = PlayingMusicController.sharePlay
            let currT = Float64(slider.value)
            playMusic.player.seekToTime(CMTimeMakeWithSeconds(currT, 1))
        }
    }
    
    func nextBtnClick() {
        if self.songNameL.text == nil {
            MyPromptTool.promptModeText("当前没有歌曲", afterDelay: 1)
        } else {
            let playMusic = PlayingMusicController.sharePlay
            playMusic.nextSongClick()
        }
        
    }
    
    func upBtnClick() {
        if self.songNameL.text == nil {
            MyPromptTool.promptModeText("当前没有歌曲", afterDelay: 1)
        } else {
            let playMusic = PlayingMusicController.sharePlay
            playMusic.upSongClick()
        }
    }

}





















