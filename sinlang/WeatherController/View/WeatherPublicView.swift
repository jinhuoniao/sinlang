//
//  WeatherPublicView.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class WeatherPublicView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var lifeInfoArr = NSMutableArray()
    var pm25Arr = NSMutableArray()
    var realTimeArr = NSMutableArray()
    var weatherArr = NSMutableArray()
    
    let headerView = WeatherHeaderView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 124))
    
    func setData(lifeInfoArr: NSMutableArray, pm25Arr: NSMutableArray, realTimeArr: NSMutableArray, weatherArr: NSMutableArray) {
        self.lifeInfoArr = lifeInfoArr
        self.pm25Arr = pm25Arr
        self.realTimeArr = realTimeArr
        self.weatherArr = weatherArr
        self.setupViews()
        self.reloadData()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        
        //self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.setHeadView()
        self.tableHeaderView = headerView
        self.tableHeaderView?.height = SCREEN_H - 64 - 60
        self.tableHeaderView?.backgroundColor = UIColor.init(white: 0.5, alpha: 0.2)
    }
    
    func setHeadView() {
        let realModel = realTimeArr[0] as! RealtimeNewModel
        let pm25Model = pm25Arr[0] as! Pm25NewModel
        self.headerView.calenderL1.text = realModel.date
        self.headerView.calenderL2.text = realModel.moon
        self.headerView.weatherBtn.numL.text = realModel.temperature
        self.headerView.weatherBtn.weatherL.text = realModel.info
        self.headerView.qualityBtn.numL.text = pm25Model.curPm
        self.headerView.qualityBtn.descL.text = pm25Model.quality
        self.headerView.weatherBtn.timeL.text = pm25Model.dateTime
    }
    
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("HourlyForecastCell") as? HourlyForecastCell
            if cell == nil {
                cell = HourlyForecastCell.init(style: .Default, reuseIdentifier: "HourlyForecastCell")
            }
            
            return cell!
        } else if indexPath.row == 1{
            var cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as? WeatherCell
            if cell == nil {
                cell = WeatherCell.init(style: .Default, reuseIdentifier: "WeatherCell")
            }
            var i:CGFloat = 0
            for m in weatherArr {
                let model = m as! WeatherNewModel
                let dL = DayLabel.init(frame: CGRectMake(i * SCREEN_W / 5, 0, SCREEN_W / 5, 180))
                dL.weekL.text = model.week
                let d1 = model.date
                let d2 = d1.componentsSeparatedByString("-")
                dL.dateL.text = "\(d2[1])/\(d2[2])"
                dL.weatherL.text = model.day[1] as? String
                cell?.view1.addSubview(dL)
                let nL = NightLabel.init(frame: CGRectMake(i * SCREEN_W / 5, 0, SCREEN_W / 5, 180))
                nL.weatherL.text = model.night[1] as? String
                nL.directL.text = model.night[3] as? String
                nL.windL.text = model.night[4] as? String
                cell?.view3.addSubview(nL)
                i += 1
            }
            return cell!
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("LifeCell") as? LifeCell
            if cell == nil {
                cell = LifeCell.init(style: .Default, reuseIdentifier: "LifeCell", dataArr: self.lifeInfoArr)
            }
            return cell!
        }
        
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myView = MyHeaderSectionView.init(frame: CGRectMake(0, 0, SCREEN_W, 60))
        let model = realTimeArr[0] as! RealtimeNewModel
        myView.tmpBtn.explainLabel.text = model.temperature
        myView.winBtn.explainLabel.text = "\(model.direct)\(model.power)"
        return myView
    }
    
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else if indexPath.row == 1{
            return 600
        } else {
            return 600
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

}














