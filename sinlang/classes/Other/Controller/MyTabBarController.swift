//
//  MyTabBarController.swift
//  weibolx
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItem()
        self.setupChildVcs()
        self.setupTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTabBar() {
        let a = MyTabBar()
        self.setValue(a, forKey: "tabBar")
    }

    func setupChildVcs() {
        self.setupChildVC(HomePageController(), title: "首页", image: "tabbar_home", selectedImage: "tabbar_home_selected")
        self.setupChildVC(MessageController(), title: "消息", image: "tabbar_message_center", selectedImage: "tabbar_message_center_selected")
        self.setupChildVC(DiscoverController(), title: "直播", image: "tabbar_discover", selectedImage: "tabbar_discover_selected")
        self.setupChildVC(MeController(), title: "我", image: "tabbar_profile", selectedImage: "tabbar_profile_selected")
    }
    
    func setupChildVC(vc: UIViewController, title: String, image: String, selectedImage: String) {
        let nav = MyNavigationController.init(rootViewController:vc)
        self.addChildViewController(nav)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage.init(named: image)?.imageWithRenderingMode(.AlwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.imageWithRenderingMode(.AlwaysOriginal)
    }
    
    func setupItem() {
        var normalAttrs = [String: AnyObject]()
        normalAttrs[NSForegroundColorAttributeName] = UIColor.grayColor()
        normalAttrs[NSFontAttributeName] = UIFont.boldSystemFontOfSize(12)
        
        var selectedAttrs = [String: AnyObject]()
        selectedAttrs[NSForegroundColorAttributeName] = UIColor.orangeColor()
        
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes(normalAttrs, forState: .Normal)
        item.setTitleTextAttributes(selectedAttrs, forState: .Selected)
    }

}
