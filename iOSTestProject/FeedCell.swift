//
//  FeedCell.swift
//  iOSTestProject
//
//  Created by Alyssa on 9/20/17.
//  Copyright © 2017 OCV,LLC. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
//    override func layoutSubviews() {
//        img.layer.cornerRadius = img.bounds.height / 2
//        img.clipsToBounds = true
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
