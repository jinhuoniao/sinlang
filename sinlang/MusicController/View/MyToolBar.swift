//
//  MyToolBar.swift
//  sinlang
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol MyToolBarDelegate: NSObjectProtocol {
    func didSelectedTitleAtIndex(index: NSInteger) -> Void
}

class MyToolBar: UIToolbar {

    var btnW: CGFloat = 0
    var space: CGFloat = 0 //距离屏幕左端的距离
    var topSpace: CGFloat = 20
    var btnH: CGFloat = 23
    var sliderView: UIView!
    var selectedIndex = 0
    
    
    weak var mydelegate: MyToolBarDelegate?
    
    init(frame: CGRect, leftSpace:CGFloat, titleArray:[String]) {
        
        super.init(frame: frame)
        space = leftSpace
        //计算按钮的宽度
        btnW = (SCREEN_W - 2 * leftSpace) / CGFloat(titleArray.count)
        self.createSubviews(titleArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews(titleArray: [String]) {
        var i = 0
        for title in titleArray {
            let button = UIButton.init(frame: CGRectMake(CGFloat(i) * btnW, topSpace, btnW, btnH))
            //设置三种状态的标题
            button.setTitle(title, forState: .Normal)
            button.setTitle(title, forState: .Selected)
            button.setTitle(title, forState: .Highlighted)
            button.tag = 200 + i
            
            button.setTitleColor(TEXTGRAYCOLOR, forState: .Normal)
            button.setTitleColor(TEXTGRAYCOLOR, forState: .Highlighted)
            button.setTitleColor(UIColor.orangeColor(), forState: .Selected)
            
            button.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
            button.addTarget(self, action: #selector(self.buttonIsClicked(_:)), forControlEvents: .TouchUpInside)
            self.addSubview(button)
            if i == 0 {
                //设置选中
                button.selected = true
            }
            i += 1
        }
        sliderView = UIView.init(frame: CGRectMake(0, self.frame.size.height - 2, btnW, 2))
        sliderView.backgroundColor = UIColor.orangeColor()
        self.addSubview(sliderView)
    }
    
    func buttonIsClicked(button: UIButton) {
        self.selectedIndex(button.tag - 200)
        self.mydelegate?.didSelectedTitleAtIndex(button.tag - 200)
        
    }
    
    //当点击到某一个下标位置时，改变按钮的选中状态
    func selectedIndex(index:NSInteger) {
        //先取出上一次选中的按钮，并置为非选中状态
        let preBtn = self.viewWithTag(200 + self.selectedIndex) as! UIButton
        preBtn.selected = false
        //取出当前选中的按钮，设置为选中状态
        let button = self.viewWithTag(200 + index) as! UIButton
        button.selected = true
        selectedIndex = index
        //设置滑块的位置
        UIView.animateWithDuration(0.25) {
            self.sliderView.mj_x = self.btnW * CGFloat(index)
        }
    }


}
