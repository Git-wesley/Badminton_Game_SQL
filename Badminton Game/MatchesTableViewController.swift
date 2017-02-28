//
//  MatchesTableViewController.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/23.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit

class MatchesTableViewController: UITableViewController {
    
    var dictData: NSDictionary!
    var listData: NSArray!
    //保存数据列表
    var listDataMatches = NSMutableArray()
    //业务逻辑对象BL
    var bl_layer = MatchBL()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let navigationController = self.parent as! UINavigationController
        let selecItem = navigationController.tabBarItem.title!
        
        NSLog("%@", selecItem)
        
        if (selecItem == "比赛") {
            self.navigationItem.title = "比赛信息"
            //查询所有的数据
            self.listDataMatches = bl_layer.findAllMatch()
            
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MatchesTableViewController.reloadViewMatch(_:)),
                                               name: NSNotification.Name(rawValue: "reloadViewNotificationMatch"),
                                               object: nil)
        
        


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // MARK: --实现表视图数据源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listDataMatches.count
    }
    //数据显示到table view中
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let array = self.listDataMatches //bl_layer.findAllMatch()
        let cellIdentifier = "CellMIdentifier"
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath)
        let row = indexPath.row
        let matchdata = array[row] as! Match
        
        //通过tag来控制在table中的label 101 user1, 102 user2, 103 user3, 104 user4, 105 socre, 106 date, 107 time
        
        let user1_label = cell.viewWithTag(101) as! UILabel
        let user2_label = cell.viewWithTag(102) as! UILabel
        let user3_label = cell.viewWithTag(103) as! UILabel
        let user4_label = cell.viewWithTag(104) as! UILabel
        let score_label = cell.viewWithTag(105) as! UILabel
        let date_label  = cell.viewWithTag(106) as! UILabel
        //let time_label  = cell.viewWithTag(107) as! UILabel
        
        
        //cell.textLabel?.text = matchdata.team1.double_team[0] as String
        //cell.detailTextLabel?.text = String(describing: matchdata.mdate).subString(start: 0, length: 19)
        user1_label.text = matchdata.team1.double_team[0] as String
        user2_label.text = matchdata.team1.double_team[1] as String
        user3_label.text = matchdata.team2.double_team[0] as String
        user4_label.text = matchdata.team2.double_team[1] as String
        score_label.text = matchdata.result as String
        date_label.text  = String(describing: matchdata.mdate).subString(start: 0, length: 19)
        //time_label.text  = String(describing: matchdata.mdate).subString(start: 11, length: 9)
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //删除table中的记录
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let match = self.listDataMatches[indexPath.row] as! Match
            self.listDataMatches = bl_layer.removeMatch(match)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: --处理通知
    func reloadViewMatch(_ notification : Notification) {
        let resList_Match = notification.object as! NSMutableArray
        self.listDataMatches = resList_Match
        self.tableView.reloadData()
    }
    
}
