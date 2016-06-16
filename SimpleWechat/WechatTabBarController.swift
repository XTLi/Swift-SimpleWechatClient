//
//  UITabBarController.swift
//  SimpleWechat
//
//  Created by LiXT on 5/4/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import UIKit

var GLOBAL_CONTACTS_SOURCE: Contacts = Contacts()
var GLOBAL_MESSAGES_SOURCE: [Message] = []
var GLOBAL_MOMENTS_SOURCE: [Moment] = []

class WechatTabBarController: UITabBarController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBar.tintColor = UIColor(red: 56/255, green: 174/255, blue: 49/255, alpha: 1)
        
        var contactsDictionary: [String: Contact] = [ : ]
        
        //利用文件模拟服务器数据，从文件中读取相关数据
        let filePath_contacts = NSBundle.mainBundle().pathForResource("ContactsList.plist", ofType: nil)
        let contactsData = NSDictionary(contentsOfFile: filePath_contacts!)
        for (_, value) in contactsData! {
            let wechatAccount = value["wechatAccount"] as! String
            let name = value["name"] as! String
            let profilePhoto = UIImage(named: value["profilePhoto"] as! String)
            let contact = Contact(wechatAccount: wechatAccount, name: name, profilePhoto: profilePhoto)
            contactsDictionary[wechatAccount] = contact
            GLOBAL_CONTACTS_SOURCE.addContact(contact)
        }
        
        let filePath_messages = NSBundle.mainBundle().pathForResource("MessagesList.plist", ofType: nil)
        let messagesData = NSArray(contentsOfFile: filePath_messages!)
        for item in messagesData! {
            let wechatAccount = item["wechatAccount"] as! String
            if let contact = contactsDictionary[wechatAccount] {
                let messageContent = item["messageContent"] as! String
                let message = Message(contact: contact, messageContent: messageContent)
                GLOBAL_MESSAGES_SOURCE.append(message)
            }
        }
        
        let filePath_moments = NSBundle.mainBundle().pathForResource("MomentsList.plist", ofType: nil)
        let momentsData = NSArray(contentsOfFile: filePath_moments!)
        for item in momentsData! {
            let wechatAccount = item["contactAccount"] as! String
            if let contact = contactsDictionary[wechatAccount] {
                let moment = Moment(contact: contact)
                if let content = item["content"] as? String {
                    moment.content = content
                }
                if let photos = item["photos"] as? [String] {
                    moment.photos = [UIImage]()
                    for photo in photos {
                        if let image = UIImage(named: photo) {
                            
                            moment.photos!.append(image)
                        }
                    }
                }
                GLOBAL_MOMENTS_SOURCE.append(moment)
            }
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
