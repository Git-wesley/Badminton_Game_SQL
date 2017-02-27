//
//  ScoreBL.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/24.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit
import Foundation

open class ScoreBL {
    
    var db:SQLiteDB!
    var userDAO = UserDAO()
    
    public init() {
        
        
    }
    //初始化，现在没看到什么用处
    
    func calculateScore(initscore : Double, Result_bool : Bool, differentScore : Double )->Int {
        var K : Double = 0.0
        var W :Double = 0.0
        
        if Result_bool {
            W = 1
        }
        
        let R0 = initscore
        
        switch R0 {
        case 0...599:
            K = 16  //32
        case 600...799:
            K = 12 //24
        case 800...1000:
            K = 8 //16
        default :
            K = 12
        }
        let Z = differentScore/400
        let X = pow(10, -Z)
        let T = 1+X
        let WE = 1/T
        let Y = W - WE
        let Rn = R0 + K * Y
        return Int(Rn)
    }
}

