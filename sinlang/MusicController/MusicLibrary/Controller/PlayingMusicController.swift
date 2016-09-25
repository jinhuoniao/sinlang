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

    class var sharePlay: PlayingMusicController {
        return playMusic
    }
    var songIdArray = NSMutableArray()
    var playingIndex = 0
    var player = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for m in songList {
//            let model = m as! SongListModel
//            let ha = model.Hash
//            let file = model.filename
//        }
        let para = ["songIds":self.songIdArray[playingIndex]]
        
        PlaySongModel.requestGetPlaySong(self.songIdArray[playingIndex] as! String) { (array, error) in
            let model = array![0] as! PlaySongModel
            let url = model.songLink
            self.player = AVPlayer.init(URL: NSURL.init(string: url)!)
            self.player.play()
        }
        
    }
}




















