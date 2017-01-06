//
//  SearchTableViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    //#MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //#MARK: Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
