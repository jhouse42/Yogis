//
//  YogiCell.swift
//  Yogis
//
//  Created by Jeanie House on 3/26/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class YogiCell: UITableViewCell {
    
    @IBOutlet weak var proImage: UIImageView!
    
    @IBOutlet weak var visEffect: UIVisualEffectView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.proImage.layer.cornerRadius = self.proImage.frame.size.width / 2;
        self.proImage.clipsToBounds = true;
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
