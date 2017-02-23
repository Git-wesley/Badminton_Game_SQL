//
//  user.swift

//  PresentationLayer
//
//  Created by wesley Du on 2017/2/13.
//  Copyright © 2017年 tony. All rights reserved.

//

import Foundation

//创建用户类
open class User {
    
    open var id_no: Int = 0
    open var name: NSString = ""
    open var nickname : NSString = ""
    open var grade : NSString = ""
    open var score : Int = 0
    open var mobile : NSString = ""
    open var date : NSDate
    
    open var match : Match?
    
    public init(id_no: Int, name: NSString, nickname : NSString, grade : NSString, score : Int, mobile : NSString, date : NSDate) {
        self.id_no = id_no
        self.name = name
        self.nickname = nickname
        self.grade = grade
        self.score = score
        self.mobile = mobile
        self.date = date
    }
    
    public init() {
        self.id_no = 1
        self.name = ""
        self.nickname = ""
        self.grade = ""
        self.score = 0
        self.mobile = ""
        self.date = NSDate()
    }
}

//创建比赛类
public struct Match {
    
    public var id_M_no : Int
    public var team1 : Team
    public var team2 : Team
    public var result : NSString = ""
    public var result_bool : Bool  // true team1 win, false team 2 win
    public var mdate : NSDate
 
    public init(in_M_no : Int,team1 : Team ,team2 : Team, result : NSString , result_bool : Bool, mdate : NSDate){
        self.id_M_no = in_M_no
        self.team1 = team1
        self.team2 = team2
        self.result = result
        self.result_bool = result_bool
        self.mdate = mdate
    }
    
}

//创建team结构
 public struct Team {
    
    var double_team : [NSString] = ["",""]
    var user1 : NSString
    var user2 : NSString
    
    public init(user1 : NSString, user2 : NSString){
        
         self.user1 = user1
         self.user2 = user2
         self.double_team[0] = user1
         self.double_team[1] = user2
    }
}

/*
open class Double_Team {
 
    open var user1 : String
    open var user2 : String
    var double_match  =  [String]()
    
    public init(user1 : String, user2 : String){
        self.double_match[0] = user1
        self.double_match[1] = user2
        
    }
    return double_match
}
*/
