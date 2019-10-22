//
//  GCConstants.swift
//  GCProject
//
//  Created by kunkun on 2019/7/16.
//  Copyright © 2019年 CJ Co,Ltd. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto
import WebKit
struct GCColor {
    let color: UIColor
    init(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) {
        
        color = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
}



//@available(iOS 11.0, *)
class GCConstant: NSObject {
    /**
     *    当前设备屏幕宽度
     */
//    static var dataHomeAry: Array<HomeListItemModel>?
    static let GCSCREENWIDTH = UIScreen.main.bounds.width;
    
    static let GCHSCALE = GCConstant.GCSCREENWIDTH/375.0
    
    static let GCHEIESCALE = GCConstant.GCSCREENHEIGHT/375.0
    
    static let UNCLEAR_SEARCH_NOTIFICATION = "unclearSearchnotify"
    
    static let GCVERSION = "3"
    
    /**apple跳转applestore Url*/
    
    static let appleStoreUrl = "itms-apps://itunes.apple.com/app/id1481166022"
    
    /**
     *   当前设备高度
     **/
    static let GCSCREENHEIGHT = UIScreen.main.bounds.height
    
    static func isiPhoneX() ->Bool {
        let screenHeight = UIScreen.main.nativeBounds.size.height;
        if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
            return true
        }
        return false
    }
    
    static let navStatusBarHeight = GCConstant.isiPhoneX() ? 88.0 : 64.0
    
    static let BottomBoxEdge = GCConstant.isiPhoneX() ? 34.0 : 0.0
    
    /**
     日志开关
     */
    static let GCLOG:Bool = true
    
    /**
     提示消息
     */
    
    
    /**
     主题颜色
     */
    static let GCMAINCOLOR = CoreUtils.GCfromHexValue(0x5CBCA1, alpha: 1.0)
    //背景色
    static let GCBGCOLOR = CoreUtils.GCfromHexValue(0xFBFBFB, alpha: 1.0)
    //标题文字颜色
    static let GCTITLECOLOR = CoreUtils.GCfromHexValue(0x000000, alpha: 1.0)
    //文字灰
    static let GCTEXTGRAYCOLOR = CoreUtils.GCfromHexValue(0x999999, alpha: 1.0)
    //主题绿
    static let GCTEXTGRREENCOLOR = CoreUtils.GCfromHexValue(0x01D4CC, alpha: 1.0)
    //按钮未选中文字颜色
    static let GCBTNDESELECTCOLOR = CoreUtils.GCfromHexValue(0xcccccc, alpha: 1.0)
    
    static let GCDEEPGRAY = CoreUtils.GCfromHexValue(0x666666, alpha: 1.0)
    
    //渐变色
    static let GRADIENT_COLOR1 = CoreUtils.GCfromHexValue(0x43BFFF, alpha:1.0)
    
    static let GRADIENT_COLOR2 = CoreUtils.GCfromHexValue(0x4390FF, alpha:1.0)
    
    //分割线颜色
    static let SEPERATECOLOR = CoreUtils.GCfromHexValue(0xEEEEEE, alpha: 1.0)
    
    static let CIWindow = UIApplication.shared.keyWindow
    /**
     接口基址 BaseUrl
     */
    static let GCServer_DEVELOPE = "http://192.168.0.146:20001/app/v1"
    static let GCSERVER_TEST = "https://test.jianchedashi.com:20001/app/v1"
    static let GCSERVER_PRODUCT = "https://api.jianchedashi.com:20001/app/v1"
    //"https://test.gc-guide.cn"
    /**正则筛选输入框*/
    static let selectRule = "[^\\u4e00-\\u9fa50-9a-zA-Z]"
    /**字典处理成加密所需字符串*/
    static func sortParams(params: Dictionary<String, Any>) ->(strResult: String, jsonStr: String) {
        if (!JSONSerialization.isValidJSONObject(params)) {
            print("无法解析出JSONString")
            return ("", "")
        }
        
        
        var muDic = NSMutableDictionary.init(dictionary: params).mutableCopy() as! NSMutableDictionary
        for keyName in params.keys {
            
            var obj = muDic.object(forKey: keyName) as! AnyObject
            
            if(obj.isKind(of: NSDictionary.self))
            {
                muDic[keyName] = GCConstant.sortValueDic(params: obj as! Dictionary<String, Any>) as AnyObject
            }
            
            if(obj.isKind(of: NSArray.self))
            {

                
                muDic[keyName] = GCConstant.sortAry(paramAry: (obj as! NSArray) as! [Any])
            }
        }
        
        var jsonResource:NSString?
        if #available(iOS 11.0, *) {
            let dataTest: NSData! = try? JSONSerialization.data(withJSONObject: params, options: [JSONSerialization.WritingOptions.sortedKeys]) as NSData
            
            jsonResource = NSString(data:dataTest as Data,encoding: String.Encoding.utf8.rawValue)
            
            print(jsonResource)
            
            
        } else {
            // Fallback on earlier versions
            let dataTest: NSData! = try? JSONSerialization.data(withJSONObject: params, options: []) as! NSData
            
            jsonResource = NSString(data:dataTest as Data,encoding: String.Encoding.utf8.rawValue)
            
        
        }
        
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: muDic, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        
//        let JsonStrRe = GCConstant.getJSONStringFromDictionary(dictionary: muDic)
        
        var jsonReStr = JSONString?.replacingCharacters(in: NSRange.init(location: 0, length: 1), with: "")
        
        let rn = Range.init(NSMakeRange((jsonReStr?.count)! - 1, 1), in: jsonReStr!)
        jsonReStr = jsonReStr?.replacingOccurrences(of: "}", with: "", options: NSString.CompareOptions.caseInsensitive, range: rn)
        jsonReStr = jsonReStr?.replacingOccurrences(of: ":", with: "=")
        let jsonAry = jsonReStr?.components(separatedBy: ",")
        var resultAry = [String]()
        
        for strItem in jsonAry!
        {
            let str = strItem.replacingOccurrences(of: "\"", with: "")
            resultAry.append(str)
        }
        resultAry.sort(by: {(str1, str2) in
            return str1 < str2
        })
        
        let resultStr = resultAry.joined(separator: "|")
        
//        var resultStr1 = resultStr.replacingOccurrences(of: "(", with: "{")
//
//        resultStr1 = resultStr1.replacingOccurrences(of: ")", with: "}")
        
        var resultStr1 = resultStr.replacingOccurrences(of: " ", with: "")
        
        resultStr1 = resultStr1.replacingOccurrences(of: "?", with: ", ")
        
        resultStr1 = resultStr1.replacingOccurrences(of: ";", with: ",")
        
        resultStr1 = resultStr1.replacingOccurrences(of: "\\n", with:"")
        
        resultStr1 = resultStr1.replacingOccurrences(of: "\\", with: "")
        
        resultStr1 = resultStr1.replacingOccurrences(of: "http=", with: "http:")
        
       
        
        return (resultStr1, jsonResource as! String)
    }
    
    
    static func sortSourceValueDic(params: Dictionary<String, Any>) -> String
    {
        if (!JSONSerialization.isValidJSONObject(params)) {
            print("无法解析出JSONString")
            return ""
        }
        
        
        
        for keyName in params.keys {
            var obj = params[keyName] as! AnyObject
            
            if(obj.isKind(of: NSDictionary.self))
            {
                obj = GCConstant.sortSourceValueDic(params: obj as! Dictionary<String, Any>) as AnyObject
            }
            
            if(obj.isKind(of: NSArray.self))
            {
                obj = GCConstant.sortArySource(paramAry: (obj as! NSArray) as! [Any]) as AnyObject
            }
        }
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: params, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        var jsonReStr = JSONString?.replacingCharacters(in: NSRange.init(location: 0, length: 1), with: "")
        
        let rn = Range.init(NSMakeRange((jsonReStr?.count)! - 1, 1), in: jsonReStr!)
        jsonReStr = jsonReStr?.replacingOccurrences(of: "}", with: "", options: NSString.CompareOptions.caseInsensitive, range: rn)
        
        let jsonAry = jsonReStr?.components(separatedBy: ",")
        var resultAry = [String]()
        
        for strItem in jsonAry!
        {
//            let str = strItem.replacingOccurrences(of: "\"", with: "")
            resultAry.append(strItem)
        }
        resultAry.sort(by: {(str1, str2) in
            return str1 < str2
        })
        
        let resultStr = resultAry.joined(separator: ", ")
        
        return "(\(resultStr))"
    }
    
    static func sortArySource(paramAry: [Any]) -> NSArray
    {
        let ary = paramAry as NSArray
        var resultAry = NSMutableArray.init(array: paramAry)
        for (idx, itm) in ary.enumerated() {
            var itmNeed = itm as AnyObject
            
            if itmNeed.isKind(of: NSDictionary.self)
            {
                itmNeed = GCConstant.sortSourceValueDic(params: itmNeed as! Dictionary<String, Any>) as AnyObject
                resultAry.replaceObject(at: idx, with: itmNeed)
            }
            
            if itmNeed.isKind(of: NSArray.self)
            {
                itmNeed = GCConstant.sortArySource(paramAry: itmNeed as! [Any]) as AnyObject
                resultAry.replaceObject(at: idx, with: itmNeed)
            }
            
        }
        
        
        var resultAry1 = [String]()
        
        resultAry1 = resultAry as! [String]
        
//        let resultStr = resultAry1.joined(separator: ",")
        
        
        return resultAry1 as NSArray
    }
    
    
    
    static func sortAry(paramAry: [Any]) -> String
    {
        let ary = paramAry as NSArray
        var resultAry = NSMutableArray.init(array: paramAry)
        for (idx, itm) in ary.enumerated() {
            var itmNeed = itm as AnyObject
            
            if itmNeed.isKind(of: NSDictionary.self)
            {
                itmNeed = GCConstant.sortValueDic(params: itmNeed as! Dictionary<String, Any>) as AnyObject
                resultAry.replaceObject(at: idx, with: itmNeed)
            }
            
            if itmNeed.isKind(of: NSArray.self)
            {
                itmNeed = GCConstant.sortAry(paramAry: itmNeed as! [Any]) as AnyObject
                resultAry.replaceObject(at: idx, with: itmNeed)
            }
            
        }
        
  
        var resultAry1 = [String]()
        
        resultAry1 = resultAry as! [String]
        
        let resultStr = resultAry1.joined(separator: "?")
        
        
        return "[\(resultStr)]"
    }
    
    static func sortValueDic(params: Dictionary<String, Any>) -> String
    {
        if (!JSONSerialization.isValidJSONObject(params)) {
            print("无法解析出JSONString")
            return ""
        }
        
        
        
        let mudic = NSMutableDictionary.init(dictionary: params)
        
        for keyName in params.keys {
            var obj = mudic[keyName] as! AnyObject
            
            
            
            if(obj.isKind(of: NSDictionary.self))
            {
                mudic[keyName] = GCConstant.sortValueDic(params: obj as! Dictionary<String, Any>) as AnyObject
            }
            
            if(obj.isKind(of: NSArray.self))
            {
                mudic[keyName] = GCConstant.sortAry(paramAry: (obj as! NSArray) as! [Any]) as AnyObject
            }
        }
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: mudic, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        var jsonReStr = JSONString?.replacingCharacters(in: NSRange.init(location: 0, length: 1), with: "")
        
        let rn = Range.init(NSMakeRange((jsonReStr?.count)! - 1, 1), in: jsonReStr!)
        jsonReStr = jsonReStr?.replacingOccurrences(of: "}", with: "", options: NSString.CompareOptions.caseInsensitive, range: rn)
        jsonReStr = jsonReStr?.replacingOccurrences(of: ":", with: "=")
        
        let jsonAry = jsonReStr?.components(separatedBy: ",")
        var resultAry = [String]()
        
        for strItem in jsonAry!
        {
            let str = strItem.replacingOccurrences(of: "\"", with: "")
            resultAry.append(str)
        }
        resultAry.sort(by: {(str1, str2) in
            
//            if str1.hasPrefix("price10Years")
//            {
//                return true
//            }
            
            return str1 < str2
        })
//
        let muary = NSMutableArray.init(array: resultAry)
        if ((muary.lastObject as AnyObject).hasPrefix("price=")) {
            let str = muary[muary.count - 2]
            muary.replaceObject(at: muary.count - 2, with: muary.lastObject)
            muary.replaceObject(at: muary.count - 1, with: str)
        }
        
        resultAry = muary as! [String]
        
        
        let resultStr = resultAry.joined(separator: "?")
        
        return "{\(resultStr)}"
    }
    
    
    //加密处理
    static func HMAC_Sign(algorithm: CCHmacAlgorithm, keyString: String, dataString: String) -> String {
        
        if algorithm != kCCHmacAlgSHA1 && algorithm != kCCHmacAlgSHA256 {
            print("Unsupport algorithm.")
            return ""
        }
        
        let keyData = keyString.data(using: .utf8)! as NSData
        let strData = dataString.data(using: .utf8)! as NSData
        let len = algorithm == CCHmacAlgorithm(kCCHmacAlgSHA1) ? CC_SHA1_DIGEST_LENGTH : CC_SHA256_DIGEST_LENGTH
        var cHMAC = [UInt8](repeating: 0, count: Int(len))
        
        CCHmac(algorithm, keyData.bytes, keyData.length, strData.bytes, strData.length, &cHMAC)
        
        ///
        var hexString = ""
        for byte in cHMAC {
            hexString += String(format: "%02x", byte)
        }

        return hexString
    }
    
    func dicValueString(_ dic:[String: Any]) ->String?{
        let data = try? JSONSerialization.data(withJSONObject: dic,options: [])
        let str = String(data: data!,encoding:String.Encoding.utf8)
        return str
        
    }
    
    
    //获取用户本地的Agent
    static func getUserAgent() -> String
    {
        let webView = UIWebView()
        
        let userAgent: String = webView.stringByEvaluatingJavaScript(from: "navigator.userAgent")!
        
        GCLogOut.LogOut("userAgent\(String(describing: userAgent))")
        return userAgent
    }
    
    
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    static func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let JSONString = GCConstant.getSourceOriJson(params: dictionary as! Dictionary<String, Any>)
        return JSONString
        
    }
    
    static func getSourceOriJson(params: Dictionary<String, Any>) -> String
    {
        let dataTest : NSData! = try? JSONSerialization.data(withJSONObject: params, options: []) as NSData!
        let JSONTest = NSString(data:dataTest as Data,encoding: String.Encoding.utf8.rawValue)
        print("JSONTest_______\(JSONTest)")
        
        var muDic = NSMutableDictionary.init(dictionary: params).mutableCopy() as! NSMutableDictionary
        for keyName in params.keys {
            var obj = params[keyName] as! AnyObject
            
            
            
            if(obj.isKind(of: NSDictionary.self))
            {
                muDic[keyName] = GCConstant.sortSourceValueDic(params: obj as! Dictionary<String, Any>) as AnyObject
            }
            
            if(obj.isKind(of: NSArray.self))
            {
                muDic[keyName] = GCConstant.sortArySource(paramAry: (obj as! NSArray) as! [Any]) as AnyObject
            }
        }
        
        
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: muDic, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        
        var jsonRe = JSONString?.replacingOccurrences(of: "", with: "")
        jsonRe = jsonRe?.replacingOccurrences(of: "\"(", with: "{")
        jsonRe = jsonRe?.replacingOccurrences(of: ")\"", with: "}, ")
//        jsonRe = jsonRe?.replacingOccurrences(of: "\\\\\\", with: "")
//        jsonRe = jsonRe?.replacingOccurrences(of: "\\\\", with: "\\")
//        jsonRe = jsonRe?.replacingOccurrences(of: "\\", with: "")
        print("jsonRE_______ (\(jsonRe))")
        return jsonRe!
    }
    
    /*json转为字典*/
    static func getDicFromJsonString(jsonStr:String) -> NSDictionary
    {
        
        
        let jsonData:Data = jsonStr.data(using: .utf8)!
        let dic = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        
        if dic != nil {
            return dic as! NSDictionary
        }
        
        return NSDictionary()
        
    }
    
    static func JSONModel<T>(_ type: T.Type, withKeyValues data:[String:Any]) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
        let model = try JSONDecoder().decode(type, from: jsonData)
        
        return model
    }
    
    static func JSONModels<T>(_ type: T.Type, withKeyValuesArray datas: [[String:Any]]) throws -> [T]  where T: Decodable {
        var temp: [T] = []
        for data in datas {
            let model = try JSONModel(type, withKeyValues: data)
            temp.append(model)
        }
        return temp
    }
}


