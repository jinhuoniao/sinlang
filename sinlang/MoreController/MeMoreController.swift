//
//  MeMoreController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MeMoreController: UIViewController {

    lazy var buttons: NSMutableArray = {
        let buttons = NSMutableArray()
        return buttons
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupButtons()
    }

    func setupButtons() {
        let images = ["publish-video","publish-picture","publish-text","publish-audio","publish-review","publish-offline"]
        let titles = ["科技新闻","发图片","发微博","发声音","听音乐","离线下载"]
        let count = images.count
        let maxColsCount = 3
        let rowsCount = CGFloat((count + maxColsCount - 1) / maxColsCount)
        let buttonW = SCREEN_W / CGFloat(maxColsCount)
        let buttonH = buttonW * 0.85
        let buttonStartY = (SCREEN_H - rowsCount * buttonH) * 0.5
        for i in 0..<count {
            let button = PublishButton.init(frame: CGRectMake(0, 0, 100, 100))
            button.addTarget(self, action: #selector(self.buttonClick(_:)), forControlEvents: .TouchUpInside)
            self.buttons.addObject(button)
            self.view.addSubview(button)
            button.setImage(UIImage.init(named: images[4]), forState: .Normal)
            button.setTitle(titles[i], forState: .Normal)
            let buttonX = CGFloat(i % maxColsCount) * buttonW
            let buttonY = buttonStartY + CGFloat(i / maxColsCount) * buttonH
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
        }
        
    }
    
    
    func buttonClick(button: PublishButton) {
        let index = self.buttons.indexOfObject(button)
        switch index {
        case 0:
            let science = ScienceController()
            self.navigationController?.pushViewController(science, animated: true)
            break
        case 4:
            break
        default:
            self.dismissViewControllerAnimated(true, completion: nil)
            break
            
        }
    }

}
