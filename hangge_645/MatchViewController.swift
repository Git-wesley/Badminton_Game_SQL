//
//  MatchViewController.swift
//  Badminton Game
//
//  Created by wesley Du on 2017/2/18.
//  Copyright © 2017年 hangge. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let navigationController = self.parent as! UINavigationController
        let selecItem = navigationController.tabBarItem.title!
        
        NSLog("%@", selecItem)
        
        if (selecItem == "比赛") {
            //self.listData = self.dictData["吉林省"] as! NSArray
            self.navigationItem.title = "比赛结果信息"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
