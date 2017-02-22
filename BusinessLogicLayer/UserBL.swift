//
//  UserBL.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/22.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit
import Foundation

open class UserBL {
    
    var db:SQLiteDB!
    var userDAO = UserDAO()
    
    public init() {
        
        
    }
    //初始化，现在没看到什么用处
    
    func initUser() {
            
            db = SQLiteDB.sharedInstance
            let data = db.query(sql: "select * from B_user")
            if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            //txtUname.text = user["uname"] as? String
            //txtMobile.text = user["umobile"] as? String
            //initUser()
        } else {
            NSLog("数据库是空的")
        }
    }
    
   
     //插入Note方法
     open func createUser(_ model: User) -> NSMutableArray {
     let dao:UserDAO = UserDAO.sharedInstance
     dao.create(model)
     return dao.findAll()
     }
    
     //删除Note方法
     open func removeUser(_ model: User) -> NSMutableArray {
     let dao:UserDAO = UserDAO.sharedInstance
     dao.remove(model)
     return dao.findAll()
     }
    
     //查询所用数据方法
     open func findAllUser() -> NSMutableArray {
     let dao:UserDAO = UserDAO.sharedInstance
     return dao.findAll()
     }
 
}

