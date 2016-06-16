//
//  MonmentsViewController.swift
//  SimpleWechat
//
//  Created by LiXT on 5/4/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import UIKit

class DiscoverViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }

    //返回发现页面的分组数
    override func numberOfSectionsInTableView(tableVie: UITableView) -> Int {
        return 4;
    }

   
    //返回每组行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    //返回自定义单元格
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscoverCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let row = indexPath.row
        let section = indexPath.section
        switch section {
        case 0:
            let momentsCell = tableView.dequeueReusableCellWithIdentifier("MomentsCell", forIndexPath: indexPath) as UITableViewCell
            momentsCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            (cell.viewWithTag(2) as! UILabel).text = "Moments"
            (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "moments")
            return momentsCell
        case 1:
            if row == 0 {
                (cell.viewWithTag(2) as! UILabel).text = "Scan QR Code"
                (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "scan-QR-code")
            }
            else {
                (cell.viewWithTag(2) as! UILabel).text = "Shake"
                (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "shake")
            }
        case 2:
            if row == 0 {
                (cell.viewWithTag(2) as! UILabel).text = "People Nearby"
                (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "people-nearby")
            }
            else {
                (cell.viewWithTag(2) as! UILabel).text = "Message in a Bottle"
                (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "message-in-a-bottle")
            }
        case 3:
            (cell.viewWithTag(2) as! UILabel).text = "Games"
            (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "games")
        default:
            break
        }
    
        return cell
    }
}
