//
//  ChefVideoControlCollectionViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class ChefVideoControlCollectionViewCell: UICollectionViewCell {
    
    //#MARK: - Outlet
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var botView: UIView!
    
    //#MARK: - Set up
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
