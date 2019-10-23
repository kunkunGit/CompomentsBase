//
//  GCCoreUtils.swift
//  GCProject
//
//  Created by kunkun on 2019/7/19.
//  Copyright © 2019年 CJ Co,Ltd. All rights reserved.
//

import Foundation
import UIKit

class CoreUtils: NSObject {
    /**
     设置控件frame
     
     *  @ parameter x:  x轴
     *  @ parameter y:  y轴
     
     *  @ returns: CGRect
     */
    
    static func GCFrame(_ x: CGFloat,_ y: CGFloat,_ width: CGFloat,_ height: CGFloat)->CGRect{
        
        return  CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    /**
     *  颜色
     */
    
    static func GCColor(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)->(UIColor){
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
    }
    
    
    /**
     返回按钮
     
     *  @ parameter sel: 事件
     
     *  @ returns: 按钮
     
     self.navigationItem.leftBarButtonItem = Constants.HDBackBarButtonItem("doThing:", taget: self)
     
     */
    
    static func GCBackBarButtonItem(_ sel:Selector,taget:AnyObject)->(UIBarButtonItem){
        
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: -10, y: 0, width: 30, height: 45)
        button.setImage(UIImage(named: "图层 19"), for: UIControl.State.normal)
        button.addTarget(taget, action: sel, for: UIControl.Event.touchUpInside)
//        button.contentMode = UIView.ContentMode.scaleToFill
        let backItem = UIBarButtonItem(customView: button)
        //(0, -10, 0, 0)
        backItem.imageInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
        
        return backItem;
    }
    
    
    /**
     16进制转RGB
     
     *  @ parameter hex:   16进制
     *  @ parameter alpha: 透明度
     
     *  @ returns: UIColor
     */
    static func GCfromHexValue(_ hex:UInt,alpha:CGFloat)->UIColor{
        
        return UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
        
    }
    
   
    
    
    /*计算字符串宽度*/
//    static func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat
//    {
//
//        let statusLabelText: NSString = labelStr as NSString
//
//        let size = CGSize(width: 900, height: height)
//
//        let dic = NSDictionary(object: font, forKey: "font" as NSCopying)
//
//        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
//
//        return strSize.width
//
//
//
//    }
   
}
