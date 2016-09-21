//
//  CommentView.swift
//  weibolx
//
//  Created by qianfeng on 16/9/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    init(frame: CGRect, arr:[String]) {
        super.init(frame: frame)
        let w = Int(self.width)
        if arr.count == 1 {
            let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: w * 2 / 3, height: w * 3 / 4))
            imgView.sd_setImageWithURL(NSURL.init(string: arr[0]))
            self.addSubview(imgView)
        }
        if arr.count <= 4 {
            var j = 0
            for i in 0..<arr.count {
                let imgView = UIImageView.init(frame: CGRect.init(x: i % 2 * w / 3, y: j * w / 3, width: w - 1, height: w - 1))
                imgView.sd_setImageWithURL(NSURL.init(string: arr[i]))
                if i == 1 {
                    j += 1
                }
                self.addSubview(imgView)
            }
        }
        if arr.count <= 9 {
            var j = 0
            for i in 0..<arr.count {
                let imgView = UIImageView.init(frame: CGRect.init(x: i % 3 * w / 3, y: j * w / 3, width: w - 1, height: w - 1))
                imgView.sd_setImageWithURL(NSURL.init(string: arr[i]))
                if i == 2 || i == 5 {
                    j += 1
                }
                self.addSubview(imgView)
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func getImg(arr:[String]) -> CommentView {
//        let myView = CommentView()
//        let w = Int(self.width)
//        if arr.count == 1 {
//            let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: w * 2 / 3, height: w * 3 / 4))
//            imgView.sd_setImageWithURL(NSURL.init(string: arr[0]))
//            myView.addSubview(imgView)
//        }
//        if arr.count <= 4 {
//            var j = 0
//            for i in 0..<arr.count {
//                let imgView = UIImageView.init(frame: CGRect.init(x: i % 2 * w / 3, y: j * w / 3, width: w - 1, height: w - 1))
//                imgView.sd_setImageWithURL(NSURL.init(string: arr[i]))
//                if i == 1 {
//                    j += 1
//                }
//                myView.addSubview(imgView)
//            }
//        }
//        if arr.count <= 9 {
//            var j = 0
//            for i in 0..<arr.count {
//                let imgView = UIImageView.init(frame: CGRect.init(x: i % 3 * w / 3, y: j * w / 3, width: w - 1, height: w - 1))
//                imgView.sd_setImageWithURL(NSURL.init(string: arr[i]))
//                if i == 2 || i == 5 {
//                    j += 1
//                }
//                myView.addSubview(imgView)
//            }
//        }
//        return myView
//    }

}
