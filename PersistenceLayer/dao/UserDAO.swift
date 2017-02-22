//
//  UserDAO.swift
//  Badminton
//
//  PresentationLayer
//
//  Created by wesley Du on 2017/2/13.
//  Copyright © 2017年 tony. All rights reserved.

//

import Foundation

let usersTableName : String = "B_userDemo"
let matchesTableName : String = "B_match"

    open class UserDAO {
        
        var db:SQLiteDB!
        
        open static let sharedInstance: UserDAO = {
            
            let instance = UserDAO()
            instance.db = SQLiteDB.sharedInstance
            let sqlUsersTable = "create table if not exists '\(usersTableName)'(uid integer primary key, uname varchar(20) , unick varchar(20), ugrade varchar(20), uscore integer, umobile varchar(20), udate TIMESTAMP)"
            
            let sqlMatchesTable = "create table if not exists '\(matchesTableName)'(mid integer primary key, uname1 varchar(20) , uname2 varchar(20) ,uname3 varchar(20) ,uname4 varchar(20) , mdate TIMESTAMP)"
            let result_User = instance.db.execute(sql: sqlUsersTable)
            let result_Match = instance.db.execute(sql: sqlMatchesTable)
            
            print(result_User)
            print(result_Match)
            
            return instance
        }()

        //插入User方法 //保存数据到SQLite
    open func create(_ model: User) -> Int {
        
        let uname = model.name
        let unick_name = model.nickname
        let ugrade = model.grade
        let uscore = model.score
        let umobile = model.mobile
        let udate = model.date
        
        let sql = "insert into \(usersTableName)(uname, unick, ugrade, uscore, umobile, udate) values('\(uname)','\(unick_name)','\(ugrade)','\(uscore)','\(umobile)','\(udate)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql: sql)
        print(result)

        return 0
    }

        //转换match类型到字典类型
    open func matchToDictionary(id_M_no : Int, user1 : String, user2 : String, user3 : String, user4 : String) -> NSDictionary {

        let team1 = Team(user1: user1, user2: user2)
        let team2 = Team(user1: user3, user2: user4)
        let dict = NSDictionary(objects: [id_M_no, team1.double_team, team2.double_team], forKeys: ["id_M_no" as NSCopying, "team1" as NSCopying, "team2" as NSCopying])
        
        return dict
     
  }

    //删除User方法 DELETE FROM T_Person WHERE id =
    open func remove(_ model: User) -> Int {

        let id_no = model.id_no
        let sql = "delete from  \(usersTableName) where uid = \(id_no)"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql: sql)
        print(result)
        
        return 0
    }

    //修改Note方法
    open func modify(_ model: User) -> Int {

        let uname = model.name
        let unick_name = model.nickname
        let ugrade = model.grade
        let uscore = model.score
        let umobile = model.mobile
        let udate = model.date
        
        /*let nowDate = NSDate()
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         let udate = formatter.string(from: nowDate as Date)
         */
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into  \(usersTableName)(uname, unick, ugrade, uscore, umobile, udate) values('\(uname)','\(unick_name)','\(ugrade)','\(uscore)','\(umobile)','\(udate)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql: sql)
        print(result)
        
        return 0
    }
        
    //查询所有数据方法
    open func findAll() -> NSMutableArray {

        let listData = NSMutableArray()
        
        db = SQLiteDB.sharedInstance
        let data = db.query(sql: "select * from  \(usersTableName) order by uscore desc")
        if data.count > 0 {
            //获取最后一行数据显示
            for user in data {
            let uid = user["uid"] as? Int
            let uname = user["uname"] as? NSString
            let unick_name = user["unick"] as? NSString
            let ugrade = user["ugrade"] as? NSString
            let uscore = user["uscore"] as? Int
            let umobile = user["umobile"] as? NSString
            let udate = user["udate"] as? NSDate
            
            let init_user  = User(id_no: uid!, name: uname!, nickname: unick_name!, grade: ugrade!, score: uscore!, mobile: umobile!, date: udate!)
            
            listData.add(init_user)
            }

        } else {
            NSLog("数据库是空的")
        }

            return listData
    }

    //按照主键查询数据方法, 未完成
        open func findById(_ model: User) -> NSMutableArray {
        
        let listData = NSMutableArray()
        let data = db.query(sql: "select * from  '\(usersTableName)' where uid = ")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            
            let uname = user["uname"] as? NSString
            let unick_name = user["unick"] as? NSString
            let ugrade = user["ugrade"] as? NSString
            let uscore = user["uscore"] as? Int
            let umobile = user["umobile"] as? NSString
            let udate = user["udate"] as? NSDate
            
            let init_user  = User(id_no: data.count, name: uname!, nickname: unick_name!, grade: ugrade!, score: uscore!, mobile: umobile!, date: udate!)
            listData.add(init_user)
            
        } else {
            NSLog("数据库是空的")
        }
        
        return listData
}
}
