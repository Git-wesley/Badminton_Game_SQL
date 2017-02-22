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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UsersTableViewController.reloadView(_:)),
                                               name: NSNotification.Name(rawValue: "reloadViewNotification"),
                                               object: nil)

        
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
            // let dict = self.listData[selectedIndex] as! NSDictionary
            
            // let detailViewController = segue.destination as! DetailViewController
            // detailViewController.url = dict["url"] as! String
            //  detailViewController.title = dict["name"] as? String
            
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
    func reloadView(_ notification : Notification) {
        let resList = notification.object as! NSMutableArray
        self.listDataUser = resList
        self.tableView.reloadData()
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}