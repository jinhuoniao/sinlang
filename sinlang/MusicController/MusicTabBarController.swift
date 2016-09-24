//
//  MusicTabBarController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MusicTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        self.setupTabBar()
        self.setupChildVC()
        // Do any additional setup after loading the view.
    }
    
    func setupTabBar() {
        let a = MusicTabBar()
        self.setValue(a, forKey: "tabBar")
    }
    
    func setupChildVC() {
        let mVC = MusicMenuController()
        let nav = MyNavigationController.init(rootViewController:mVC)
        self.addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
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
