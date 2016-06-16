//
//  Messages.swift
//  SimpleWechat
//
//  Created by LiXT on 5/10/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import Foundation

class Message {
    var messageContent: String = ""
    let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    init(contact: Contact, messageContent: String) {
        self.contact = contact
        self.messageContent = messageContent
    }
    
    func addNewMessageContent(newContent: String) {
        self.messageContent = self.messageContent + newContent
    }
    
}