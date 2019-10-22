//
//  GCLog.swift
//  GCProject
//
//  Created by kunkun on 2019/7/23.
//  Copyright © 2019年 CJ Co,Ltd. All rights reserved.
//

import Foundation


/*
 *   日志管理
 */
class GCLogOut {
    
    static func LogOut(_ obj:Any){
        
        if GCConstant.GCLOG {
            
            print("\(obj)")
            
        }
        
    }
    
    static func LogOut(_ obj_name:Any,obj:Any){
        
        if GCConstant.GCLOG {
            
            print("\(obj_name):  \(obj)")
            
        }
        
    }
    
    static func LogClassDestory(_ className:Any){
        
        if GCConstant.GCLOG {
            
            print("\(className) destory")
            
        }
    }
    
}
