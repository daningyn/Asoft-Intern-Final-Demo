//
//  SettingHaveSwitchTableViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class SettingHaveSwitchTableViewCell: UITableViewCell {

    //#MARK: - Outlet
    @IBOutlet weak var optionTextLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    //#MARK: - Set up
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
