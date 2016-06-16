//
//  MeViewController.swift
//  SimpleWechat
//
//  Created by LiXT on 5/9/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import UIKit


class MeViewController: UITableViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
            return 4
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    //返回不同section的cell高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = indexPath.section
        if section == 0 {
            return 90
        }
        else {
            return 45
        }
    }
    
    //返回自定义单元格
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 0 {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("MyProfileCell", forIndexPath: indexPath) as UITableViewCell
            
            cell1.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            (cell1.viewWithTag(2) as! UILabel).text = "MY NAME"
            (cell1.viewWithTag(1) as! UIImageView).image = UIImage(named: "contact14")
            (cell1.viewWithTag(3) as! UILabel).text = "WeChat ID: my wechat ID"
            (cell1.viewWithTag(4) as! UIImageView).image = UIImage(named: "my-QR-code")

            return cell1
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("MeCell", forIndexPath: indexPath) as UITableViewCell
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            switch section {
            case 1:
                if row == 0 {
                    (cell.viewWithTag(2) as! UILabel).text = "My Posts"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "my-posts")
                }
                else if row == 1 {
                    (cell.viewWithTag(2) as! UILabel).text = "Favorites"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "favorites")
                }
                else if row == 2 {
                    (cell.viewWithTag(2) as! UILabel).text = "Wallet"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "wallet")
                }
                else if row == 3 {
                    (cell.viewWithTag(2) as! UILabel).text = "Coupons"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "coupons")
                }
            case 2:
                (cell.viewWithTag(2) as! UILabel).text = "Sticker Gallery"
                (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "sticker-gallery")
            case 3:
                (cell.viewWithTag(2) as! UILabel).text = "Settings"
                (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "settings")
                
            default:
                break
            }
            return cell
        }
    }

    
}
