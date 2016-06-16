//
//  ChatsViewController.swift
//  SimpleWechat
//
//  Created by LiXT on 5/10/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import UIKit

class ChatsViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    var searchController: UISearchController?
    
    var searchBar: UISearchBar?
    
    var messageList: [Message] = [Message]()
    var filtedMessageList: [Message] = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化数据
        self.messageList = GLOBAL_MESSAGES_SOURCE
        self.filtedMessageList = messageList
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
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
    }

   
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if self.searchController?.active == true {
            self.filtedMessageList.removeAll()
            for message in self.messageList {
                let searchContent = self.searchController?.searchBar.text!.lowercaseString
                if message.contact.name.lowercaseString.hasPrefix(searchContent!) {
                    self.filtedMessageList.append(message)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.filtedMessageList.removeAll()
        self.filtedMessageList = self.messageList
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtedMessageList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath)
        
        (cell.viewWithTag(1) as! UIImageView).image = self.filtedMessageList[indexPath.row].contact.profilePhoto
        (cell.viewWithTag(2) as! UILabel).text = self.filtedMessageList[indexPath.row].contact.name
        (cell.viewWithTag(3) as! UILabel).text = self.filtedMessageList[indexPath.row].messageContent
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
}
