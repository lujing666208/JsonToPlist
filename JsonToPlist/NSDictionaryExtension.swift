//
//  NSDictionaryExtension.swift
//  JsonToPlist
//
//  Created by lujing on 16/7/4.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

import Foundation

extension NSDictionary{
    //如果replacer是nil,则会删除所有的null;如果是字符串，则会将所有的null值替换为这个字符串
    func replaceAllNullValueWithString(replacer:String?)-> NSDictionary{
        func replaceNullValueInObject(obj:AnyObject,withString replacer:String?)->AnyObject{//嵌套函数，递归
            if obj is NSDictionary {//如果是字典
                let dict = obj as! NSDictionary
                let mDict = NSMutableDictionary(dictionary: dict)
                for (key,value) in dict {
                    if value is NSNull {
                        mDict[key as! String] = replacer
                    } else if (value is NSArray)||(value is NSDictionary) {//字典套数组
                        mDict[key as! String] = replaceNullValueInObject(value,withString: replacer)
                    }
                }
                return mDict
            } else if obj is NSArray {
                let arr = obj as! NSArray
                let mArr = NSMutableArray()
                for value in arr {
                    if (value is NSDictionary)||(value is NSArray) {//数组套字典,或者数组套数组
                        mArr.addObject(replaceNullValueInObject(value,withString: replacer))
                    } else if value is NSNull {
                        if replacer != nil {
                            mArr.addObject(replacer!)
                        }
                    } else {
                        mArr.addObject(value)
                    }
                }
                return mArr
            }
            return obj
        }
        
        return replaceNullValueInObject(self,withString: replacer) as! NSDictionary
    }
}
