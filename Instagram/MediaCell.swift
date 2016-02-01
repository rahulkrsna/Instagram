//
//  MediaCell.swift
//  Instagram
//
//  Created by Rahul Krishna Vasantham on 1/27/16.
//  Copyright © 2016 rahulkrnsa. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {

    @IBOutlet var pictureView: UIImageView!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var profileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
