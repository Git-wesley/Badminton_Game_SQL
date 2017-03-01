//
//  MatchDAO.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/23.
//  Copyright © 2017年 hangge. All rights reserved.
//

import Foundation

let matchesTableName : String = "matches_demo"

open class MatchDAO {
    
    var db:SQLiteDB!
    
    open static let sharedInstance: MatchDAO = {
        
        let instance = MatchDAO()
        instance.db = SQLiteDB.sharedInstance
        let sqlMatchesTable = "create table if not exists '\(matchesTableName)'(mid integer primary key, mname1 varchar(20) , mname2 varchar(20) ,mname3 varchar(20) ,mname4 varchar(20) , mresult varchar(20), mresult_bool integer, mdate TIMESTAMP)"
        let result_Match = instance.db.execute(sql: sqlMatchesTable)
        
        print(result_Match)
        
        return instance
    }()
    
    //插入User方法 //保存数据到SQLite
    open func create(_ model: Match) -> Int {
        
        let mName1 = model.team1.user1
        let mName2 = model.team1.user2
        let mName3 = model.team2.user1
        let mName4 = model.team2.user2
        let mResult = model.result
        let mResult_bool = model.result_bool ? 1: 0  // as Int
        let mdate = model.mdate
    
        let sql = "insert into \(matchesTableName)(mname1, mname2, mname3, mname4, mresult, mresult_bool, mdate) values('\(mName1)','\(mName2)','\(mName3)','\(mName4)','\(mResult)','\(mResult_bool)','\(mdate)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql: sql)
        print(result)
        
        return 0
    }
    
    //转换match类型到字典类型
    /*
    open func matchToDictionary(id_M_no : Int, user1 : String, user2 : String, user3 : String, user4 : String) -> NSDictionary {
        
        let team1 = Team(user1: user1, user2: user2)
        let team2 = Team(user1: user3, user2: user4)
        let dict = NSDictionary(objects: [id_M_no, team1.double_team, team2.double_team], forKeys: ["id_M_no" as NSCopying, "team1" as NSCopying, "team2" as NSCopying])
        
        return dict
        
    }
    */
    //删除User方法 DELETE FROM T_Person WHERE id =
    open func remove(_ model: Match) -> Int {
        
        let id_no = model.id_M_no
        let sql = "delete from  \(matchesTableName) where mid = \(id_no)"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql: sql)
        print(result)
        
        return 0
    }
    
    //修改Note方法
    open func modify(_ model: Match) -> Int {
        
        let mName1 = model.team1.user1
        let mName2 = model.team1.user2
        let mName3 = model.team1.user1
        let mName4 = model.team1.user2
        let mdate = model.mdate
        
        let sql = "insert into \(matchesTableName)(mname1, mname2, mname3, mname4, udate) values('\(mName1)','\(mName2)','\(mName3)','\(mName4)','\(mdate)')"
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
        let data = db.query(sql: "select * from  \(matchesTableName) order by mdate desc")
        if data.count > 0 {
            //获取最后一行数据显示
            for match in data {
                let mid = match["mid"] as? Int
                let mName1 = match["mname1"] as? NSString
                let mName2 = match["mname2"] as? NSString
                let mName3 = match["mname3"] as? NSString
                let mName4 = match["mname4"] as? NSString
                let mResult = match["mresult"] as? NSString
                let mteam1 = Team(user1: mName1!, user2: mName2!)
                let mteam2 = Team(user1: mName3!, user2: mName4!)
                let mdate = match["mdate"] as? NSDate
                let mResult_Int = match["mresult_bool"] as? Int
                var mResult_bool = false
                
                if (mResult_Int! > 0 ) {
                 mResult_bool = true
                }

                let init_match  = Match(in_M_no: mid!, team1: mteam1, team2: mteam2, result : mResult!, result_bool : mResult_bool,  mdate: mdate!)
                listData.add(init_match)
            }
            
        } else {
            NSLog("数据库是空的")
        }
        
        return listData
    }
    
    //按照主键查询数据方法, 未完成
    open func findById(_ model: Match) -> NSMutableArray {
        
        let listData = NSMutableArray()
        let mId = model.id_M_no
        let data = db.query(sql: "select * from  '\(matchesTableName)' where uid = \(mId)")
        if data.count > 0 {
            //转化数据
            for match in data {
                let mid = match["mid"] as? Int
                let mName1 = match["mname1"] as? NSString
                let mName2 = match["mname2"] as? NSString
                let mName3 = match["mname3"] as? NSString
                let mName4 = match["mname4"] as? NSString
                let mResult = match["mresult"] as? NSString
                let mteam1 = Team(user1: mName1!, user2: mName2!)
                let mteam2 = Team(user1: mName3!, user2: mName4!)
                let mdate = match["mdate"] as? NSDate
                let mResult_Int = match["mresult_bool"] as? Int
                var mResult_bool = false
                
                if (mResult_Int! > 0 ) {
                    mResult_bool = true
                }
                
                let init_match  = Match(in_M_no: mid!, team1: mteam1, team2: mteam2, result : mResult!, result_bool : mResult_bool,  mdate: mdate!)
                listData.add(init_match)
            }
            
        } else {
            NSLog("数据库中没有相关用户数据")
        }
        return listData
    }
    //按照主键查询数据方法, 未完成
    open func findByUserName(_ model: Match) -> NSMutableArray {
        
        let listData = NSMutableArray()
        let mName1 = model.team1.user1
        let mName2 = model.team1.user1
        let mName3 = model.team1.user1
        let mName4 = model.team1.user1
        //let mdate = model.mdate
        let sqlStr = "select * from  '\(matchesTableName)' where mname1 = '\(mName1)' or mname2 = '\(mName2)' or mname3 = '\(mName3)' or mname4 = '\(mName4)'"
        //print(sqlStr)
        let data = db.query(sql: sqlStr)
        if data.count > 0 {
            //转化数据
            for match in data {
                let mid = match["mid"] as? Int
                let mName1 = match["mname1"] as? NSString
                let mName2 = match["mname2"] as? NSString
                let mName3 = match["mname3"] as? NSString
                let mName4 = match["mname4"] as? NSString
                let mResult = match["mresult"] as? NSString
                let mteam1 = Team(user1: mName1!, user2: mName2!)
                let mteam2 = Team(user1: mName3!, user2: mName4!)
                let mdate = match["mdate"] as? NSDate
                let mResult_Int = match["mresult_bool"] as? Int
                var mResult_bool = false
                
                if (mResult_Int! > 0 ) {
                    mResult_bool = true
                }
                
                let init_match  = Match(in_M_no: mid!, team1: mteam1, team2: mteam2, result : mResult!, result_bool : mResult_bool,  mdate: mdate!)
                listData.add(init_match)
            }
            
        } else {
            NSLog("数据库中没有相关用户数据")
        }
        return listData
    }
    

}
