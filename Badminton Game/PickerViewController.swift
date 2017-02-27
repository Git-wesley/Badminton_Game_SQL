//
//  PickerViewController.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/24.
//  Copyright © 2017年 hangge. All rights reserved.
//
import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var pickerView2: UIPickerView!
    //数据持久对象db
    var db:SQLiteDB!

    //保存数据列表
    var listDataUser = NSMutableArray()
    //业务逻辑对象BL
    var bl = UserBL()

    var pickerData : NSDictionary!          //保存全部数据
    var pickerUsersData : [String] = []
    var pickerUsersIDData : [Int] = []
    var pickerTeamData: NSArray! = ["Team1", "Team2"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listDataUser = bl.findAllUser()
        let array = self.listDataUser
        for index in 0 ..< array.count{
            let Sstring = (array[index] as! User).name as String
           
            pickerUsersData.append(Sstring)
            pickerUsersIDData.append((array[index] as! User).id_no as Int)
            
        }
        pickerData = arrayToDictionary(pickerUsersData: pickerUsersData)
        
        //默认取出第一个省的所有市的数据
        let seletedProvince = self.pickerTeamData[0] as! String
       self.pickerUsersData = (self.pickerData[seletedProvince] as! NSArray) as! [String]
        
    }
    
    
    //转换Array to dictionary 类型到字典类型
    open func arrayToDictionary(pickerUsersData : [String]) -> NSDictionary {
        
        let dict = NSDictionary(objects: [pickerUsersData, pickerUsersData], forKeys: ["Team1" as NSCopying, "Team2" as NSCopying])
        
        return dict
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveClick(_ sender: Any) {
        //team1
        let row1 = self.pickerView.selectedRow(inComponent: 0)
        let row2 = self.pickerView.selectedRow(inComponent: 1)
        
        let selected1 = self.pickerUsersData[row1]  //let selected1 = self.pickerTeamData[row1] as! String
        let selected2 = self.pickerUsersData[row2] 
        let title = String(format: "Team1 : %@，%@", selected1, selected2)
         let Team_user : [String] = [selected1,selected2]
        print(title)
        //team2
        let row1T2 = self.pickerView2.selectedRow(inComponent: 0)
        let row2T2 = self.pickerView2.selectedRow(inComponent: 1)
        
        let selected1T2 = self.pickerUsersData[row1T2]  //let selected1 = self.pickerTeamData[row1] as! String
        let selected2T2 = self.pickerUsersData[row2T2]
        let titleT2 = String(format: "Team2 : %@，%@", selected1T2, selected2T2)
        let Team_userT2 : [String] = [selected1T2,selected2T2]
        print(titleT2)
        let Team_Users : [String] = [Team_user[0],Team_user[1] ,Team_userT2[0],Team_userT2[1]]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadViewNotificationSelectUser"), object: Team_Users, userInfo: nil)
        
        self.dismiss(animated: true, completion: nil)
      
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        
         self.dismiss(animated: true, completion: nil)
        
    }
    // MARK: --实现协议UIPickerViewDataSource方法
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       	if (component == 0) {//Team个数
            return self.pickerUsersData.count //return self.pickerTeamData.count
           } else {//注册用户数
            return self.pickerUsersData.count
        }
    }
    
    // MARK: --实现协议UIPickerViewDelegate方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       	if (component == 0) {//选择team
            return self.pickerUsersData[row]  //as? String // return self.pickerTeamData[row] as? String
           } else {//参赛人员
            return self.pickerUsersData[row] //as? String
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            _ = self.pickerUsersData[row]
            //self.pickerUsersData = (self.pickerData[seletedProvince] as! NSArray) as! [String]
            self.pickerView.reloadComponent(1)
        }
    }
}
