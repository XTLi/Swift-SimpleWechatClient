//
//  ViewController.swift
//  SimpleWechat
//
//  Created by LiXT on 5/2/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController: UISearchController?
    
    var contacts: Contacts = Contacts()
    var filtedContacts: [Contact] = [Contact]()
    
    var search: UISearchBar?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化联系人
        self.contacts = GLOBAL_CONTACTS_SOURCE
        
        //创建rightBarButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-contacts"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        //设置navigationBar的颜色
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
       
        //创建UISearchController
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.delegate = self
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Default
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        //创建Footer View显示联系人总数
        self.addFooterView()
    }
    
    //实现UISearchResultsUpdating协议，完成搜索栏功能
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        if self.searchController?.active == true {
            self.tableView.tableFooterView?.hidden = true
        }
        else {
            self.tableView.tableFooterView?.hidden = false
        }
        self.tableView.reloadSectionIndexTitles()
        
        self.filtedContacts.removeAll(keepCapacity: false)
        for (_, value) in self.contacts.contactsDictionary {
            for contact in value {
                let searchContent = self.searchController?.searchBar.text!.lowercaseString
                if contact.name.lowercaseString.hasPrefix(searchContent!) {
                    self.filtedContacts.append(contact)
                }
            }
        }
        self.tableView.reloadData()
       
    }
    
    //返回联系人分组数
    override func numberOfSectionsInTableView(tableVie: UITableView) -> Int {
        if self.searchController?.active == true {
            return 1
        }
        else {
            return (contacts.contactsSection) + 1;
        }
    }

    //返回每组联系人行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController?.active != true {
            if section == 0 {
                return 4
            }
            else {
                let initial = self.contacts.contactsInitials[section - 1]
                return (contacts.contactsDictionary[initial]?.count) ?? 0
            }
        }
        else {
            return self.filtedContacts.count
        }
    }
    
    //返回自定义单元格
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        let section = indexPath.section
        
        if self.searchController?.active == true {
            (cell.viewWithTag(2) as! UILabel).text = filtedContacts[row].name
            (cell.viewWithTag(1) as! UIImageView).image = filtedContacts[row].profilePhoto
            return cell
        }
        else {
            if section == 0 {
                switch row {
                case 0:
                    (cell.viewWithTag(2) as! UILabel).text = "New Friends"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "new-friends")
                case 1:
                    (cell.viewWithTag(2) as! UILabel).text = "Saved Groups"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "saved-groups")
                case 2:
                    (cell.viewWithTag(2) as! UILabel).text = "Tags"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "tags")
                case 3:
                    (cell.viewWithTag(2) as! UILabel).text = "Official Accounts"
                    (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "official-accounts")
                default: break
                }
            }
            else {
                let initial = contacts.contactsInitials[section - 1]
                let contactsInThisSetion = contacts.contactsDictionary[initial]
                let contactAtThisRow = contactsInThisSetion?[row]
                (cell.viewWithTag(2) as! UILabel).text = contactAtThisRow?.name
                (cell.viewWithTag(1) as! UIImageView).image = contactAtThisRow?.profilePhoto
            }
            return cell
        }
    }
    
    //返回每个section的header
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        let initial = contacts.contactsInitials[section - 1]
        return initial
    }
    
    //增加FooterView显示联系人总数
    func addFooterView() {
        
        let line = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 0.5))
        line.backgroundColor = UIColor.lightGrayColor()
        
        let footerView:UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 52))
        let footerlabel:UILabel = UILabel(frame: footerView.bounds)
        footerlabel.textColor = UIColor.grayColor()
        footerlabel.backgroundColor = UIColor.clearColor()
        footerlabel.font = UIFont.systemFontOfSize(16)
        footerlabel.text = "\(contacts.contactsCount) contact(s)"
        footerlabel.textAlignment = .Center
        
        footerView.addSubview(line)
        footerView.addSubview(footerlabel)
        footerView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = footerView
    }
    
    //设置section index
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        if self.searchController?.active == true {
            return nil
        }
        self.tableView.sectionIndexBackgroundColor = UIColor.clearColor()
        self.tableView.sectionIndexColor = UIColor.grayColor()
        return contacts.contactsInitials
    }    
}

