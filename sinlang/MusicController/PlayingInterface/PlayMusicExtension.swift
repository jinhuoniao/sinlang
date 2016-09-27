//
//  PlayMusicExtension.swift
//  sinlang
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

extension PlayingMusicController: NSURLSessionDownloadDelegate {
    
    func setSontIdArray(array: NSMutableArray, currentIndex index: NSInteger) {
        self.songIdArray = array
        self.playingIndex = index
        self.loadSongDetail(self.songIdArray[playingIndex] as! String)
    }
    
    func loadSongDetail(songUrl: String) {
        PlaySongModel.requestGetPlaySong(songUrl) { (array, error) in
            self.currentSong = array![0] as! PlaySongModel
            self.settingView()
            self.getSongLrc(self.currentSong.lrcLink)
            let url = self.currentSong.songLink
            self.myPlay(url)
        }
    }
    
    func settingView() {
        self.songL.text = self.currentSong.songName
        self.singerL.text = self.currentSong.artistName
        tab.setContent(self.currentSong, songIdArray: self.songIdArray, currentIndex: self.playingIndex)
        tab.setNeedsDisplay()
    }
    
    func myPlay(url: String) {
        self.player = AVPlayer.init(URL: NSURL.init(string: url)!)
        self.player.play()
        self.isPlaying = true
        self.playBtn.setImage(UIImage.init(named: "icon_ios_music_pause"), forState: .Normal)
        self.player.addPeriodicTimeObserverForInterval(CMTimeMake(1, 1), queue: dispatch_get_global_queue(0, 0)) { (time) in
            var cTime: CMTime = CMTime.init()
            cTime = self.player.currentTime()
            let second = CMTimeGetSeconds(cTime)
            let allSecond = CMTimeGetSeconds((self.player.currentItem?.duration)!)
            
            dispatch_async(dispatch_get_main_queue(), {
                if(isnan(CMTimeGetSeconds((self.player.currentItem?.duration)!))) {
                    self.slider.maximumValue = Float(CMTimeGetSeconds(self.player.currentTime()))
                } else {
                    self.slider.maximumValue = Float(CMTimeGetSeconds((self.player.currentItem?.duration)!))
                    self.startL.text = self.timeStrFrom(second)
                    self.endL.text = self.timeStrFrom(allSecond)
                    self.slider.value = Float(CMTimeGetSeconds(self.player.currentTime()))
                    self.tab.slider.maximumValue = Float(CMTimeGetSeconds((self.player.currentItem?.duration)!))
                    self.tab.slider.value = Float(CMTimeGetSeconds(self.player.currentTime()))
                    //循环播放
                    if second >= allSecond - 1 {
                        if self.playingIndex < self.songIdArray.count - 1 {
                            self.playingIndex += 1
                        } else {
                            self.playingIndex = 0
                        }
                        let songUrl = self.songIdArray[self.playingIndex] as! String
                        self.loadSongDetail(songUrl)
                    }
                }
            })
        }
    }
    
    func timeStrFrom(time: NSTimeInterval) -> String {
        let minute = Int(time / 60)
        let second = Int(time % 60)
        return String.init(format: "%02d:%02d", minute, second)
    }
    
    //MARK:－－获取歌词
    func getSongLrc(urlStr: String) {
        let request = NSURLRequest.init(URL: NSURL.init(string: urlStr)!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.mysession = NSURLSession.init(configuration: config, delegate: self, delegateQueue: nil)
        self.task = self.mysession?.downloadTaskWithRequest(request)
        self.task?.resume()
        
    }
    
    //MARK:  session协议方法
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let lrcArrayM = NSMutableArray()
        
        //let str = String.init(format: "/Users/qianfeng/Desktop/myLrc/%@-%@", self.songL.text!, self.singerL.text!)
        let str = String.init(format: "/Documents/%@-%@", self.songL.text!, self.singerL.text!)
        let path = NSHomeDirectory().stringByAppendingString(str)
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(path) {
            //try! fileManager.removeItemAtPath(path)
            try! fileManager.moveItemAtURL(location, toURL: NSURL.init(fileURLWithPath: path))
        }
        let lrc = try! String.init(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        let array = lrc.componentsSeparatedByString("\n")
        for str: String in array {
            if lrc.hasPrefix("[ti:") || lrc.hasPrefix("[ar:") || lrc.hasPrefix("[al:") || !lrc.hasPrefix("[") {
                continue
            }
            let lrcModel = LrcModel.lrcModelWithLrcString(str)
            lrcArrayM.addObject(lrcModel)
        }
        scrollView.lrcArr = lrcArrayM
        scrollView.tableView.reloadData()
        
        
    }
    
    //MARK:  歌词布局
    func addLrcTimer() {
        self.lrcTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(self.updateLrcTimer), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.lrcTimer, forMode: NSRunLoopCommonModes)
    }
    
    func updateLrcTimer() {
        self.scrollView.currentTime = CMTimeGetSeconds(self.player.currentTime())
        self.scrollView.setContont(self.scrollView.currentTime)
    }
    
    func backBtnClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func playBtnClick() {
        self.isPlaying = !self.isPlaying
        if isPlaying == true {
            self.playBtn.setImage(UIImage.init(named: "icon_ios_music_pause"), forState: .Normal)
            self.tab.playBtn.setImage(UIImage.init(named: "icon_ios_music_pause"), forState: .Normal)
            self.tab.isPlay = true
            self.player.play()
        } else {
            self.playBtn.setImage(UIImage.init(named: "icon_ios_music_play"), forState: .Normal)
            self.tab.playBtn.setImage(UIImage.init(named: "icon_ios_music_play"), forState: .Normal)
            self.tab.isPlay = false
            self.player.pause()
        }
    }
    
    func sliderValueChange() {
        let currT = Float64(slider.value)
        player.seekToTime(CMTimeMakeWithSeconds(currT, 1))
    }
    
    func nextSongClick() {
        if self.playingIndex < songIdArray.count - 1 {
            self.playingIndex += 1
        } else {
            self.playingIndex = 0
        }
        let urlStr = self.songIdArray[playingIndex] as! String
        self.loadSongDetail(urlStr)
    }
    
    func upSongClick() {
        if self.playingIndex > 0{
            self.playingIndex -= 1
        } else {
            self.playingIndex = songIdArray.count - 1
        }
        let urlStr = self.songIdArray[playingIndex] as! String
        self.loadSongDetail(urlStr)
        
    }
}


















