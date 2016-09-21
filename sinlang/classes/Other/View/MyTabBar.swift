//
//  MyTabBar.swift
//  weibolx
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {
    
    let publishButton = UIButton.init(type: .Custom)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundImage = UIImage.init(named: "tabbar_background")
        publishButton.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), forState: .Normal)
        publishButton.setImage(UIImage.init(named: "tabbar_compose_icon_add"), forState: .Normal)
        publishButton.sizeToFit()
        publishButton.addTarget(self, action: #selector(self.publishClick), forControlEvents: .TouchUpInside)
        self.addSubview(publishButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func publishClick() {
        let publish = PublishController()
        self.window?.rootViewController?.presentViewController(publish, animated: true, completion: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
        self.publishButton.center = CGPointMake(width * 0.5, height * 0.5)
        var index: CGFloat = 0
        let tabBarButtonW = width / 5
        let tabBarButtonH = height
        let tabBarButtonY: CGFloat = 0
        for tabBarButton in self.subviews {
            if "\(tabBarButton.classForCoder)" != "UITabBarButton" {
                continue
            }
            var tabBarButtonX = index * tabBarButtonW
            if index >= 2 {
                tabBarButtonX += tabBarButtonW
            }
            tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH)
            index += 1
        }
    }
}