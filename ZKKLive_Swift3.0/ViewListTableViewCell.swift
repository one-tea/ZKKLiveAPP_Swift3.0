//
//  ViewListTableViewCell.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/29.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class ViewListTableViewCell: UITableViewCell {

	@IBOutlet weak var icoImageView: UIImageView!
	@IBOutlet weak var nameLB: UILabel!
	@IBOutlet weak var locationLB: UILabel!
	@IBOutlet weak var concernNumLB: UILabel!
	@IBOutlet weak var bgImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.icoImageView.layer.cornerRadius = 5.0
		self.icoImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
