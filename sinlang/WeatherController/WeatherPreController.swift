//
//  WeatherPreController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class WeatherPreController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        self.navigationItem.hidesBackButton = true
        self.setupViews()
        let weather = WeatherController()
        if CityInfo.cityInfoSaved() {
            self.navigationController?.pushViewController(weather, animated: true)
        } else {
            CityInfoModel.requestCityInfo({ 
                self.navigationController?.pushViewController(weather, animated: true)
            })
        }
    }
    
    func setupViews() {
        let messageL = UILabel()
        self.view.addSubview(messageL)
        messageL.text = "正在配置城市信息，请稍候。。。"
        messageL.font = UIFont.boldSystemFontOfSize(20)
        messageL.textColor = UIColor.blueColor()
        messageL.sd_layout().centerXEqualToView(self.view).centerYEqualToView(self.view).heightIs(30).widthIs(320)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
