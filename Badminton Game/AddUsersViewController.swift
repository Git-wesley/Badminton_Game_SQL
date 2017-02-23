//
//  ViewController.swift
//  hangge_645
//
//  Created by hangge on 2016/10/31.
//  Copyright © 2016年 hangge. All rights reserved.
//

import UIKit

class AddUsersViewController: UIViewController, UITextFieldDelegate {
    
    //数据持久对象db
    var db:SQLiteDB!
    
    //业务逻辑对象BL
    var bl = UserBL()
    
    @IBOutlet var txtUname: UITextField!
    @IBOutlet var txtMobile: UITextField!
    var dropBoxView_currentTitle : String = ""
 
    @IBAction func DoneCloseKeyBoard(_ sender: Any) {
        txtMobile.resignFirstResponder()
    }
    override func viewDidLoad() {
     
        super.viewDidLoad()
        self.txtUname.delegate = self
        self.txtUname.becomeFirstResponder()
        
        //下拉选择框
        self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        let defaultTitle = "中级"
        self.dropBoxView_currentTitle = defaultTitle
        let choices = ["高级", "中级", "初级"]
        let rect = CGRect(x: 135, y: 310, width: 130, height: 30)
        let dropBoxView = TGDropBoxView(parentVC: self, title: defaultTitle, items: choices, frame: rect)
        
        dropBoxView.isHightWhenShowList = true
        dropBoxView.willShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("will show choices") }
            else { NSLog("will hide choices") }
        }
        dropBoxView.didShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("did show choices") }
            else { NSLog("did hide choices") }
        }
        dropBoxView.didSelectBoxItemHandler = { (row) in
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
            self.dropBoxView_currentTitle = dropBoxView.currentTitle()
        }
        self.view.addSubview(dropBoxView)
}
    
    func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        txtMobile.resignFirstResponder()
    }
    //点击保存
    @IBAction func saveClicked(_ sender: AnyObject) {
        
        let user = User()
        user.date = Date() as NSDate
        user.name = txtUname.text! as NSString
        user.nickname = ""
        user.grade = self.dropBoxView_currentTitle as NSString
        user.score = 500
        user.mobile = txtMobile.text! as NSString
        
        let reslist = bl.createUser(user) //(user)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadViewNotification"), object: reslist, userInfo: nil)
        self.dismiss(animated: true, completion: nil)

    }
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query(sql: "select * from B_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtMobile.text = user["umobile"] as? String
        } else {
            NSLog("数据库是空的")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //收起键盘
        NSLog("textFieldShouldReturn")
        self.txtUname.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    

}
