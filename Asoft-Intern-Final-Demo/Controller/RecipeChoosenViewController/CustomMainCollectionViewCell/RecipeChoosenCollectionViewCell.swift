//
//  RecipeChoosenCollectionViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/4/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class RecipeChoosenCollectionViewCell: UICollectionViewCell {
    
    //#MARK: - Outlet
    @IBOutlet weak var mainTableView: UITableView!
    
    //#MARK: - Define properties
    var haveButton = false
    
    //#MARK: - Set up
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
