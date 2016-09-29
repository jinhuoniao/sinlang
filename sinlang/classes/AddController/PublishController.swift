//
//  PublishController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class PublishController: UIViewController {

    lazy var buttons: NSMutableArray = {
        let buttons = NSMutableArray()
        return buttons
    }()
    lazy var times: NSArray = {
        let interval = 0.1
        let times = [5 * interval, 4 * interval, 3 * interval, 2 * interval, 0 * interval, 1 * interval, 6 * interval]
        return times
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        self.view.userInteractionEnabled = true
        self.setupButtons()
    }
    
    func setupButtons() {
        let images = ["publish-video","publish-picture","publish-text","publish-audio","publish-review","publish-offline"]
        let titles = ["发视频","发图片","发微博","发声音","听音乐","离线下载"]
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
            button.setImage(UIImage.init(named: images[i]), forState: .Normal)
            button.setTitle(titles[i], forState: .Normal)
            let buttonX = CGFloat(i % maxColsCount) * buttonW
            let buttonY = buttonStartY + CGFloat(i / maxColsCount) * buttonH
            let anim = POPSpringAnimation.init(propertyNamed: kPOPViewFrame)
            anim.fromValue = NSValue.init(CGRect: CGRectMake(buttonX, buttonStartY - SCREEN_H, buttonW, buttonH))
            anim.toValue = NSValue.init(CGRect: CGRectMake(buttonX, buttonY, buttonW, buttonH))
            anim.springSpeed = 10
            anim.springBounciness = 10
            anim.beginTime = CACurrentMediaTime() + self.times[i].doubleValue
            button.pop_addAnimation(anim, forKey: nil)
            
            
        }
        
    }
    
    //    func exit(_: () -> Void) {
    //        for i in 0..<self.buttons.count {
    //            let button = self.buttons[i]
    //            let anim = POPBasicAnimation.init(propertyNamed: kPOPLayerPositionY)
    //            anim.toValue = button.layer.position.y + SCREEN_H
    //            anim.beginTime = CACurrentMediaTime() + self.times[i].doubleValue
    //            button.layer.pop_addAnimation(anim, forKey: nil)
    //        }
    //        let anim = POPBasicAnimation.init(propertyNamed: kPOPLayerPositionY)
    //        anim.toValue = SCREEN_H + 200
    //        anim.beginTime = CACurrentMediaTime() + (self.times.lastObject?.doubleValue)!
    //        self.dismissViewControllerAnimated(true, completion: nil)
    //    }
    
    func buttonClick(button: PublishButton) {
        let index = self.buttons.indexOfObject(button)
        switch index {
        case 2:
            let write = WriteController()
            write.titleStr = "写微博"
            write.textPlace = "写微博..."
            self.presentViewController(write, animated: true, completion: nil)
        case 4:
            let musicController = MusicTabBarController()
            self.presentViewController(musicController, animated: true, completion: nil)
        default:
            self.dismissViewControllerAnimated(true, completion: nil)
            break
            
        }
    }

    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
