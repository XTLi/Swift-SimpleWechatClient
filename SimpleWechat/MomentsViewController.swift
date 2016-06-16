//
//  MomentsViewController.swift
//  SimpleWechat
//
//  Created by LiXT on 5/10/16.
//  Copyright © 2016 LiXT. All rights reserved.
//

import UIKit

class MomentsViewController: UITableViewController {
    
    @IBOutlet weak var coverView: UIView!
    
    var momentDataSource: [Moment] = []
    
    var momentsCells: [UITableViewCell] = []
    
    var coverWidth: CGFloat {
        get {
            return self.tableView.frame.size.width
        }
    }
    
    var coverHeight: CGFloat {
        get {
            let height = (self.tableView.frame.size.height - (self.navigationController?.navigationBar.frame.height)!)/2
            return height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //初始化数据
        self.momentDataSource = GLOBAL_MOMENTS_SOURCE
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.frame.size.height
        
        (self.coverView.viewWithTag(3) as! UIImageView).image = UIImage(named: "moments-cover")
        (self.coverView.viewWithTag(2) as! UIImageView).image = UIImage(named: "contact14")
        (self.coverView.viewWithTag(1) as! UILabel).text = "MY NAME"
        
        for moment in self.momentDataSource {
            createMomentCell(moment)
        }

    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.momentsCells[indexPath.row].frame.height
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let a = self.momentDataSource.count
        return a
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return momentsCells[indexPath.row]
    }
    
    func createMomentCell(moment: Moment) {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("MomentCell")!
        
        (cell.viewWithTag(1) as! UIImageView).image = moment.contact.profilePhoto
        (cell.viewWithTag(2) as! UILabel).text = moment.contact.name
        
        let momentContentView = cell.viewWithTag(3)! as UIView
        
        let cellWidth = cell.frame.width
        let cellHeight = momentContentView.frame.origin.y
        
        let momentContentViewWidth: CGFloat = momentContentView.frame.width
        var momentContentViewHeight: CGFloat = 0.0
        
        let labelWidth: CGFloat = momentContentViewWidth
        var labelHeight: CGFloat = 0.0
        
        let space: CGFloat = 10.0
        
        if let momentContent = moment.content {
            let momentContentLabel = self.initMomentContentLabel(momentContent, labelWidth: labelWidth)
            momentContentView.addSubview(momentContentLabel)
            
            labelHeight = momentContentLabel.frame.height
            momentContentViewHeight += labelHeight + space
        }
        
        if let momentPhotos = moment.photos {
            let photoWidth: CGFloat = 70.0
            let photoHeight: CGFloat = 70.0
            let photosCount = momentPhotos.count
            for i in 0..<photosCount {
                let pointX = CGFloat(i % 3) * (photoWidth + space)
                let pointY = CGFloat(i / 3) * (photoHeight + space) + momentContentViewHeight
                let imageView = UIImageView(frame: CGRectMake(pointX, pointY, photoWidth, photoHeight))
                imageView.image = momentPhotos[i]
                momentContentView.addSubview(imageView)
            }
            if photosCount > 3 {
                momentContentViewHeight += 2 * photoHeight + 2 * space
            }
            else if photosCount <= 3 && photosCount > 0{
                momentContentViewHeight += photoHeight + space
            }
        }
        
        momentContentView.frame.size = CGSizeMake(momentContentViewWidth, momentContentViewHeight)
        cell.frame.size = CGSizeMake(cellWidth, cellHeight + momentContentViewHeight + space)
        self.momentsCells.append(cell)
    }
    
    func initMomentContentLabel(momentContent: String, labelWidth: CGFloat) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = momentContent
        label.textAlignment = NSTextAlignment.Natural
        label.font = UIFont.systemFontOfSize(12)
        
        let options: NSStringDrawingOptions = .UsesLineFragmentOrigin
        let boundingRect = label.text!.boundingRectWithSize(CGSizeMake(labelWidth, 0), options: options, attributes: [NSFontAttributeName:label.font], context: nil)
        label.frame = CGRectMake(0, 0, boundingRect.size.width, boundingRect.size.height)
        return label
    }
 
}
