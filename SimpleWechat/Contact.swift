//
//  Contacts.swift
//  SimpleWechat
//
//  Created by LiXT on 5/6/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import Foundation
import UIKit


class Contact {
    var wechatAccount: String
    var name: String
    var profilePhoto: UIImage?
    
    init(wechatAccount: String, name: String, profilePhoto: UIImage?) {
        self.wechatAccount = wechatAccount
        self.name = name
        self.profilePhoto = profilePhoto
    }
}

class Contacts {
    var contactsDictionary: [String: [Contact]]
    var contactsCount: Int {
        get {
            var count = 0
            for contacts in self.contactsDictionary {
                count += contacts.1.count
            }
            return count
        }
    }
    var contactsSection: Int {
        get {
            return contactsDictionary.count
        }
        set {
            
        }
    }
    var contactsInitials: [String] {
        get{
            return (Array(contactsDictionary.keys)).sort()
        }
        set {
            
        }
    }
    
    init() {
        self.contactsDictionary = [String: [Contact]]()
        //self.contactsCount = 0;
        self.contactsSection = 0;
        self.contactsInitials = [String]()
    }
    
    init(newContactsDictionary: [String: [Contact]]) {
        self.contactsDictionary = newContactsDictionary
        self.contactsSection = newContactsDictionary.count
        self.contactsInitials = Array(newContactsDictionary.keys).sort()
    }
    
    func addContact(newContact: Contact)  {
        let index = newContact.name.startIndex
      

        var initialCharacter = (newContact.name.uppercaseString)[index]
        
        if initialCharacter.toInt() < 65 || initialCharacter.toInt() > 90 {
            initialCharacter = "#"
        }
        var initial = String()
        initial.append(initialCharacter)
        
        if self.contactsDictionary[initial] != nil {
            self.contactsDictionary[initial]?.append(newContact)
        }
        else {
            self.contactsDictionary[initial] = [Contact](count: 1, repeatedValue: newContact)
            self.contactsSection += 1
        }
    }
}

extension Character
{
    func toInt() -> Int
    {
        var intFromCharacter:Int = 0
        for scalar in String(self).unicodeScalars
        {
            intFromCharacter = Int(scalar.value)
        }
        return intFromCharacter
    }
}
