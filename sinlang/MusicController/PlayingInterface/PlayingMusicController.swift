//
//  PlayingMusicController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import AVFoundation

let playMusic = PlayingMusicController()

class PlayingMusicController: UIViewController {

    var songN = "狮子座"
    var singerN = "曾轶可"
    class var sharePlay: PlayingMusicController {
        return playMusic
    }
    let tab = MusicTabBar.shareMusicBar()
    var isPlaying = false
    var progressTimer = NSTimer()
    var lrcTimer = NSTimer()
    
    var playLrc = NSArray()
    var mysession: NSURLSession?
    var task: NSURLSessionDownloadTask?
    var downloadData: NSData?
    
    var songIdArray = NSMutableArray()
    var playingIndex = 0
    var player = AVPlayer()
    var currentSong: PlaySongModel!
    
    let topSpace:CGFloat = 20
    let lfSpace: CGFloat = 50
    var backBtn = UIButton.init(type: .Custom)
    var songL = UILabel()
    var singerL = UILabel()
    var linkBtn = UIButton.init(type: .Custom)
    var voiceBtn = UIButton.init(type: .Custom)
    var coverBtn = UIButton.init(type: .Custom)
    var scrollView = LrcView()
    var view1 = UIView()
    var likeBtn = UIButton.init(type: .Custom)
    var downloadBtn = UIButton.init(type: .Custom)
    var commentBtn = UIButton.init(type: .Custom)
    var shareBtn = UIButton.init(type: .Custom)
    var moreBtn = UIButton.init(type: .Custom)
    var startL = UILabel()
    var endL = UILabel()
    var slider = UISlider()
    var modeBtn = UIButton.init(type: .Custom)
    var upBtn = UIButton.init(type: .Custom)
    var playBtn = UIButton.init(type: .Custom)
    var nextBtn = UIButton.init(type: .Custom)
    var listBtn = UIButton.init(type: .Custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        self.setupViews()
        self.loadSongDetail(self.songIdArray[playingIndex] as! String)
        self.addLrcTimer()
    }
    
    func setupViews() {
        self.view.addSubview(scrollView)
        self.view.addSubview(backBtn)
        self.view.addSubview(songL)
        self.view.addSubview(singerL)
        self.view.addSubview(linkBtn)
        self.view.addSubview(voiceBtn)
        self.view.addSubview(coverBtn)
        self.view.addSubview(view1)
        self.view1.addSubview(likeBtn)
        self.view1.addSubview(downloadBtn)
        self.view1.addSubview(commentBtn)
        self.view1.addSubview(shareBtn)
        self.view1.addSubview(moreBtn)
        self.view1.addSubview(startL)
        self.view1.addSubview(endL)
        self.view1.addSubview(slider)
        self.view1.addSubview(modeBtn)
        self.view1.addSubview(upBtn)
        self.view1.addSubview(playBtn)
        self.view1.addSubview(nextBtn)
        self.view1.addSubview(listBtn)
        
        backBtn.setImage(UIImage.init(named: "goback"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(self.backBtnClick), forControlEvents: .TouchUpInside)
        //songL.text = songN
        songL.font = UIFont.boldSystemFontOfSize(20)
        songL.textColor = UIColor.whiteColor()
        songL.textAlignment = .Center
        //singerL.text = singerN
        singerL.font = UIFont.systemFontOfSize(15)
        singerL.textColor = UIColor.whiteColor()
        singerL.textAlignment = .Center
        startL.textColor = UIColor.whiteColor()
        startL.font = UIFont.systemFontOfSize(12)
        endL.textColor = UIColor.init(white: 1, alpha: 1)
        endL.font = UIFont.systemFontOfSize(12)
        linkBtn.setTitle("标准", forState: .Normal)
        linkBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        linkBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        voiceBtn.setTitle("音效", forState: .Normal)
        voiceBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        voiceBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        coverBtn.setTitle("封面", forState: .Normal)
        coverBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        coverBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        likeBtn.setImage(UIImage.init(named: "icon_ios_heart"), forState: .Normal)
        downloadBtn.setImage(UIImage.init(named: "cm2_lay_icn_dld"), forState: .Normal)
        commentBtn.setImage(UIImage.init(named: "timeline_icon_comment"), forState: .Normal)
        shareBtn.setImage(UIImage.init(named: "timeline_icon_retweet"), forState: .Normal)
        moreBtn.setImage(UIImage.init(named: "icon_ios_more_tiny"), forState: .Normal)
        slider.setThumbImage(UIImage.init(named: "thumb"), forState: UIControlState.Normal)
        slider.userInteractionEnabled = true
        modeBtn.setImage(UIImage.init(named: "icon_ios_replay"), forState: .Normal)
        upBtn.setImage(UIImage.init(named: "icon_ios_music_backward"), forState: .Normal)
        upBtn.addTarget(self, action: #selector(self.upSongClick), forControlEvents: .TouchUpInside)
        playBtn.setImage(UIImage.init(named: "icon_ios_music_play"), forState: .Normal)
        playBtn.addTarget(self, action: #selector(self.playBtnClick), forControlEvents: .TouchUpInside)
        nextBtn.setImage(UIImage.init(named: "icon_ios_music_forward"), forState: .Normal)
        nextBtn.addTarget(self, action: #selector(self.nextSongClick), forControlEvents: .TouchUpInside)
        listBtn.setImage(UIImage.init(named: "icon_ios_list"), forState: .Normal)
        
        
        
        backBtn.sd_layout().leftSpaceToView(self.view, aSpace).topSpaceToView(self.view, topSpace).widthIs(40).heightIs(40)
        songL.sd_layout().topSpaceToView(self.view, topSpace).centerXEqualToView(self.view).heightIs(30).widthIs(200)
        singerL.sd_layout().topSpaceToView(self.songL, aSpace).centerXEqualToView(self.view).heightIs(20).widthIs(200)
        voiceBtn.sd_layout().centerXEqualToView(self.view).topSpaceToView(self.singerL, bSpace).widthIs(60).heightIs(30)
        linkBtn.sd_layout().rightSpaceToView(self.voiceBtn, aSpace).topSpaceToView(self.singerL, bSpace).widthIs(60).heightIs(30)
        coverBtn.sd_layout().leftSpaceToView(self.voiceBtn, aSpace).topSpaceToView(self.singerL, bSpace).widthIs(60).heightIs(30)
        view1.sd_layout().bottomEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(120)
        scrollView.sd_layout().topSpaceToView(self.voiceBtn, bSpace).bottomSpaceToView(self.view1, bSpace).leftEqualToView(self.view).rightEqualToView(self.view)
        commentBtn.sd_layout().centerXEqualToView(self.view1).topSpaceToView(self.view1, 0).widthIs(40).heightIs(30)
        downloadBtn.sd_layout().rightSpaceToView(self.commentBtn, lfSpace).topSpaceToView(self.view1, 0).widthIs(40).heightIs(30)
        likeBtn.sd_layout().rightSpaceToView(self.downloadBtn, lfSpace).topSpaceToView(self.view1, 0).widthIs(40).heightIs(30)
        shareBtn.sd_layout().leftSpaceToView(self.commentBtn, lfSpace).topSpaceToView(self.view1, 0).widthIs(40).heightIs(30)
        moreBtn.sd_layout().leftSpaceToView(self.shareBtn, lfSpace).topSpaceToView(self.view1, 0).widthIs(40).heightIs(30)
        startL.sd_layout().leftSpaceToView(self.view1, aSpace).widthIs(40).heightIs(30).topSpaceToView(self.commentBtn, aSpace)
        endL.sd_layout().rightSpaceToView(self.view1, aSpace).widthIs(40).heightIs(30).topSpaceToView(self.commentBtn, aSpace)
        slider.sd_layout().topSpaceToView(self.commentBtn, bSpace).heightIs(20).leftSpaceToView(self.startL, aSpace).rightSpaceToView(self.endL, aSpace)
        slider.addTarget(self, action: #selector(self.sliderValueChange), forControlEvents: .TouchUpInside)
        playBtn.sd_layout().centerXEqualToView(self.view1).bottomSpaceToView(self.view1, bSpace).widthIs(50).heightIs(50)
        upBtn.sd_layout().bottomSpaceToView(self.view1, 2 * bSpace).rightSpaceToView(self.playBtn, bSpace * 2).widthIs(30).heightIs(30)
        modeBtn.sd_layout().bottomSpaceToView(self.view1, 2 * bSpace).rightSpaceToView(self.upBtn, 50).widthIs(30).heightIs(30)
        nextBtn.sd_layout().bottomSpaceToView(self.view1, 2 * bSpace).leftSpaceToView(self.playBtn, bSpace * 2).widthIs(30).heightIs(30)
        listBtn.sd_layout().bottomSpaceToView(self.view1, 2 * bSpace).leftSpaceToView(self.nextBtn, 50).widthIs(30).heightIs(30)
        
    }
    
    
    
    
    
    
}



























