//
//  WeatherController.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    let imgView = UIImageView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H))
    let uView = UIView()
    let backBtn = UIButton.init(type: .Custom)
    lazy var tableView: WeatherPublicView = {
        let tableView = WeatherPublicView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64), style: .Plain)
        tableView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.2)
        tableView.headerView.qualityBtn.numL.text = "100"
        self.view.addSubview(tableView)
        return tableView
    }()
    
    let lifeInfoArr = NSMutableArray()
    let pm25Arr = NSMutableArray()
    let realTimeArr = NSMutableArray()
    let weatherArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 0.5, alpha: 0.2)
        self.view.addSubview(imgView)
        self.view.sendSubviewToBack(imgView)
        self.imgView.image = UIImage.init(named: "timg.jpg")
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.getData()
    }
    
    func getData() {
        WeatherNewModel.requestWeather("海淀") { (lifeInfoArr, pm25Arr, realTimeArr, weatherArr, error) in
            if error != nil {
                return
            }
            self.lifeInfoArr.addObjectsFromArray(lifeInfoArr!)
            self.pm25Arr.addObjectsFromArray(pm25Arr!)
            self.realTimeArr.addObjectsFromArray(realTimeArr!)
            self.weatherArr.addObjectsFromArray(weatherArr!)
            self.tableView.setData(self.lifeInfoArr, pm25Arr: self.pm25Arr, realTimeArr: self.realTimeArr, weatherArr: self.weatherArr)
            let model = self.realTimeArr[0] as! RealtimeNewModel
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: model.cityName, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.selectCityClick))
            
        }
    }
    
    
    
    //MARK: button点击事件

    func selectCityClick() {
        
    }
}





































