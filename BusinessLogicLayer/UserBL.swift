//
//  NoteBL.swift
//  PresentationLayer
//
//  Created by wesley Du on 2017/2/13.
//  Copyright © 2017年 tony. All rights reserved.
//

import Foundation
import PersistenceLayer

open class UserBL {
    
    public init() {
    }
    
    //插入Note方法
    open func createUser(_ model: User) -> NSMutableArray {
        let dao:UserDAO = UserDAO.sharedInstance
        dao.create(model)
        return dao.findAll()
    }
    
    //删除Note方法
    open func remove(_ model: User) -> NSMutableArray {
        let dao:UserDAO = UserDAO.sharedInstance
        dao.remove(model)
        return dao.findAll()
    }
    
    //查询所用数据方法
    open func findAll() -> NSMutableArray {
        let dao:UserDAO = UserDAO.sharedInstance
        return dao.findAll()
    }
    
}
