//
//  RecipeChoosenButtonTableViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/4/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class RecipeChoosenButtonTableViewCell: UITableViewCell {

    //#MARK: - Outlet
    @IBOutlet weak var btnWatchVideo: UIButton!
    
    //#MARK: - Set up
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //#MARK: - Button Clicked
    @IBAction func didTouchUpInsideButton(_ sender: Any) {
    }

}
