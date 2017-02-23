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
    var bl = MatchBL()
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
        let mdate = NSDate()
        
        let team1 = Team(user1: mName1,user2: mName2)
        let team2 = Team(user1: mName3,user2: mName4)
        
        
        let match = Match(in_M_no: 0, team1: team1, team2: team2, result : mResult, result_bool : mResult_bool, mdate: mdate)
        
        let reslist = bl.createMatch(match) //(user)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadViewNotification"), object: reslist, userInfo: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
