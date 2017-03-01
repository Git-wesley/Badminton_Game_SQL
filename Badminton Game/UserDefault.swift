//
//  UserDefault.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/3/1.
//  Copyright © 2017年 hangge. All rights reserved.
//

import Foundation
//工具类,放置一些经常用到的方法
//通过userDefault存储数据,进行正向传值
class baseClass{
    
    func cacheSetString(key: String,value: String){
        let userInfo = UserDefaults()
        userInfo.setValue(value, forKey: key)
    }
    
    func cacheGetString(key: String) -> String{
        let userInfo = UserDefaults()
        let tmpSign = userInfo.string(forKey: key)
        return tmpSign!
    }
}
