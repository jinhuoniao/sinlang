//
//  WeatherButton.swift
//  sinlang
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 qianfeng. All rights reserved.
//
import UIKit

class WeatherButton: UIButton {

    var timeL = UILabel()
    var numL = UILabel()
    var celsiusL = UILabel()
    var weatherL = UILabel()
    var meL = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        timeL = UILabel.init(frame: CGRectMake(0, 0, self.width, self.height / 6))
        numL = UILabel.init(frame: CGRectMake(0, self.height / 6, self.width / 3 * 2, self.height / 6 * 3))
        celsiusL = UILabel.init(frame: CGRectMake(self.width / 3 * 2, self.height / 6, self.width / 3, self.height / 6 * 2))
        weatherL = UILabel.init(frame: CGRectMake(self.width / 3 * 2, self.height / 2, self.width / 3, self.height / 6))
        meL = UILabel.init(frame: CGRectMake(0, self.height / 6 * 4, self.width, self.height / 8 * 2))
        
        self.addSubview(timeL)
        self.addSubview(numL)
        self.addSubview(celsiusL)
        self.addSubview(weatherL)
        self.addSubview(meL)
        
        timeL.text = "今天17:16发布"
        timeL.textColor = UIColor.whiteColor()
        timeL.font = UIFont.systemFontOfSize(15)
        numL.text = "20"
        numL.textColor = UIColor.whiteColor()
        numL.font = UIFont.boldSystemFontOfSize(100)
        celsiusL.text = "℃"
        celsiusL.textColor = UIColor.whiteColor()
        celsiusL.font = UIFont.boldSystemFontOfSize(50)
        celsiusL.textAlignment = .Left
        weatherL.text = "晴间多云"
        weatherL.textColor = UIColor.whiteColor()
        weatherL.font = UIFont.boldSystemFontOfSize(15)
        weatherL.textAlignment = .Right
        meL.text = "我来报天气"
        meL.textColor = UIColor.whiteColor()
        meL.font = UIFont.boldSystemFontOfSize(20)
        meL.layer.backgroundColor = UIColor.init(white: 1, alpha: 0.2).CGColor
        meL.layer.cornerRadius = 5
    }
    

}
