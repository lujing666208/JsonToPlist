//
//  main.swift
//  JsonToPlist
//
//  Created by lujing on 16/7/1.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

import Foundation

//测试1：简单字典带null
print("测试1：简单字典带null")
let dict:NSDictionary = ["name":NSNull(),"age":20]
print(dict.replaceAllNullValueWithString("hello"))

//测试2：字典套数组，数组中有null
print("测试2：字典套数组，数组中有null")
let dict1:NSDictionary = ["name":NSNull(),"age":20,"books":["c语言","swift",NSNull()]]
print(dict1.replaceAllNullValueWithString("111"))

//测试3：字典套数组，数组又套字典，字典中又有null
print("测试3：字典套数组，数组又套字典，字典中又有null")

let dict2:NSDictionary = ["name":"xiaocao","books":[["n":"C语言","a":NSNull()]]]
print(dict2.replaceAllNullValueWithString(nil))

//测试4：字典套数组，数组中有null且又套字典，字典中又有null
print("测试4：字典套数组，数组中有null且又套字典，字典中又有null")
let dict3:NSDictionary = ["name":NSNull(),"age":20,"books":["c语言","swift",NSNull(),["bookName":"HTML5","author":NSNull()]]]
print(dict3.replaceAllNullValueWithString("||||||||"))

//测试5：字典套字典，字典中又有null
print("测试5：字典套字典，字典中又有null")
let dict4:NSDictionary = ["name":"xiaocao","book":["bookName":"HTML5","author":NSNull()]]
print(dict4.replaceAllNullValueWithString("佚名"))


if let jsonString = try? NSString(contentsOfFile: "/Users/lujing/Desktop/Swift/高级阶段/json副本.txt", encoding: NSUTF8StringEncoding) {
    let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
    
    if var dict = try? NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as? NSDictionary {
        
        dict = dict!.replaceAllNullValueWithString("")
        
        dict!.writeToFile("/Users/lujing/Desktop/Swift/高级阶段/weibo.plist", atomically: true)
    }
}
