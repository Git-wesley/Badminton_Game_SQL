//
//  UsersTableViewController.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/18.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    
    var dictData: NSDictionary!
    var listData: NSArray!
    //保存数据列表
    var listDataUser = NSMutableArray()
    //业务逻辑对象BL
    var bl = UserBL()
    var scoreBL = ScoreBL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let plistPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist"
        //self.dictData = NSDictionary(contentsOfFile: plistPath!)
        
        let navigationController = self.parent as! UINavigationController
        let selecItem = navigationController.tabBarItem.title!
        
        NSLog("%@", selecItem)
        if (selecItem == "用户") {
            self.navigationItem.title = "用户信息"
            //查询所有的数据
            self.listDataUser = bl.findAllUser()
           
        }
        
        //初始化刷新
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData),
                                       for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        refreshData()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UsersTableViewController.reloadViewUser(_:)),
                                               name: NSNotification.Name(rawValue: "reloadViewNotificationUser"),
                                               object: nil)
       
}
    // 刷新数据
    func refreshData() {
        
        self.listDataUser = bl.findAllUser()
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: --选择表视图行时触发
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ShowDetail") {
            
            let indexPath = self.tableView.indexPathForSelectedRow! as IndexPath
            let selectedIndex = indexPath.row
            }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

                // MARK: --实现表视图数据源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listDataUser.count
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let array = self.listDataUser
        let cellIdentifier = "CellIdentifier"
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:indexPath)
        let row = indexPath.row
        let userdata = array[row] as! User
        cell.textLabel?.text = userdata.name as String        
        cell.detailTextLabel?.text = String(userdata.score)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = self.listDataUser[indexPath.row] as! User
            self.listDataUser = bl.removeUser(user)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
          // MARK: --处理通知
    func reloadViewUser(_ notification : Notification) {
        let resList_User = notification.object as! NSMutableArray
        self.listDataUser = resList_User
        self.tableView.reloadData()
    }

}
