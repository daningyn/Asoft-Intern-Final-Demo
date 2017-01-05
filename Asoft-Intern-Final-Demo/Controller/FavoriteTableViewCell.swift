//
//  FavoriteTableViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/5/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    //#MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //#MARK: - Set up
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
