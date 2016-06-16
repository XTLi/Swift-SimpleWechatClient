//
//  MomentsAlbum.swift
//  SimpleWechat
//
//  Created by LiXT on 5/12/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import Foundation
import UIKit

class Moment {
    var photos: [UIImage]?
    var content: String?
    var likeList: [Contact]?
    var comments: [String]?
    var publishedTime: NSDate?
    var contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
}


