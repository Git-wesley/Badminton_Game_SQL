//
//  MatchViewController.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/18.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController ,UITextFieldDelegate{
    //数据持久对象db
    var db:SQLiteDB!
    
    //业务逻辑对象BL
    var Matchbl = MatchBL()
    var userbl = UserBL()
    var scoreBL = ScoreBL()
    
    var Select_User : [String] = []
    var segueValue :String = ""
    
    @IBOutlet weak var m_user1: UITextField!
    @IBOutlet weak var m_user3: UITextField!
    @IBOutlet weak var m_user2: UITextField!
    @IBOutlet weak var m_user4: UITextField!
    @IBOutlet weak var Ascore: UITextField!
    @IBOutlet weak var Bscore: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.m_user1.delegate = self
        self.m_user1.becomeFirstResponder()
        self.m_user2.delegate = self
        self.m_user2.becomeFirstResponder()
        self.m_user3.delegate = self
        self.m_user3.becomeFirstResponder()
        self.m_user4.delegate = self
        self.m_user4.becomeFirstResponder()
        self.Ascore.delegate = self
        self.Ascore.becomeFirstResponder()
        self.Bscore.delegate = self
        self.Bscore.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MatchViewController.reloadViewSelectUser(_:)),
                                               name: NSNotification.Name(rawValue: "reloadViewNotificationSelectUser"),
                                               object: nil)
        



}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveClick(_ sender: Any) {
        
        //let mTeam2 = model.team2.double_team
        let mName1 = m_user1.text! as NSString
        let mName2 = m_user2.text! as NSString
        let mName3 = m_user3.text! as NSString
        let mName4 = m_user4.text! as NSString
        let resultStr = Ascore.text! + ":" + Bscore.text!
        let mResult = resultStr as NSString
        let mResult_bool = getMatchResult(Ascore: Ascore, Bscore: Bscore)
        //let mdate = NSDate()
        // 设置系统时区为本地时区
        let zone:NSTimeZone = NSTimeZone.system as NSTimeZone
        // 计算本地时区与 GMT 时区的时间差
        let second:Int = zone.secondsFromGMT
        let mdate:NSDate = NSDate(timeIntervalSinceNow: TimeInterval(second))
        
        let team1 = Team(user1: mName1,user2: mName2)
        let team2 = Team(user1: mName3,user2: mName4)
        
        let user1 = User()
        let user2 = User()
        let user3 = User()
        let user4 = User()
        user1.name = mName1
        user2.name = mName2
        user3.name = mName3
        user4.name = mName4
        let user1Score = getUserScore(user: user1)
        let user2Score = getUserScore(user: user2)
        let user3Score = getUserScore(user: user3)
        let user4Score = getUserScore(user: user4)
        let team1Average = (user1Score + user2Score)/2
        let team2Average = (user3Score + user4Score)/2
        updateUser(user: user1, result_bool: mResult_bool, pkAverageScore: team2Average)
        updateUser(user: user2, result_bool: mResult_bool, pkAverageScore: team2Average)
        updateUser(user: user3, result_bool: !mResult_bool, pkAverageScore: team1Average)
        updateUser(user: user4, result_bool: !mResult_bool, pkAverageScore: team1Average)
        
        let match = Match(in_M_no: 0, team1: team1, team2: team2, result : mResult, result_bool : mResult_bool, mdate: mdate)
        
        let reslist_Match = Matchbl.createMatch(match) //(user)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadViewNotificationMatch"), object: reslist_Match, userInfo: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func getUserScore(user : User)-> Double{
        
        //user1.name = mName1
        let listData = userbl.findByName(user)
        let userdata = listData[0] as! User
        let score = Double(String(userdata.score))
        return score!
    }
    
    func updateUser(user : User, result_bool : Bool, pkAverageScore : Double)-> Void{
        
        //user1.name = mName1
        let listData = userbl.findByName(user)
        let userdata = listData[0] as! User
        let score = Double(String(userdata.score))
        let different_score = pkAverageScore - score!
        user.score = scoreBL.calculateScore(initscore: score!, Result_bool: result_bool, differentScore: different_score)
       _ = userbl.modifyUser(user)
    }

    @IBAction func cancelClick(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //收起键盘
        NSLog("textFieldShouldReturn")
        self.m_user1.resignFirstResponder()
        self.m_user2.resignFirstResponder()
        self.m_user3.resignFirstResponder()
        self.m_user4.resignFirstResponder()
        self.Ascore.resignFirstResponder()
        self.Bscore.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func getMatchResult(Ascore : UITextField, Bscore : UITextField ) -> Bool {
        let scoreA = stringToInt(str: Ascore.text! as String)
        let scoreB = stringToInt(str: Bscore.text! as String)
        if (scoreA > scoreB){
            return true
        }else {
        return false
        }
    }
    func stringToInt(str:String)->(Int){
            
        let string = str
        var int: Int?
        if let doubleValue = Int(string) {
            int = Int(doubleValue)
        }
        if int == nil
        {
            return 0
        }
        return int!

    }
    
    // MARK: --选择表视图行时触发
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var segueCharacters = ""
        segueCharacters = segue.identifier!
        
        switch segueCharacters {
        case  "IdentifierUser1" :
            self.segueValue = "User1"
        case "IdentifierUser2" :
            self.segueValue = "User2"
        case "IdentifierUser3" :
            self.segueValue = "User3"
        case  "IdentifierUser4" :
            self.segueValue = "User4"
        case  "IdentifierTeamA" :
            self.segueValue = "TeamA"
        case  "IdentifierTeamB" :
            self.segueValue = "TeamB"

        default :
            self.segueValue = "User1"
         
        }
    }

    // MARK: --处理通知
    func reloadViewSelectUser(_ notification : Notification) {
        let resList_Match = notification.object as! NSArray
        self.Select_User = resList_Match  as! [String]
        
        //switch segueValue {
        
            m_user1.text = self.Select_User[0]
            m_user2.text = self.Select_User[1]
            m_user3.text = self.Select_User[2]
            m_user4.text = self.Select_User[3]
        
        
        //self.tableView.reloadData()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
