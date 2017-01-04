//
//  RecipeChoosenViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/4/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class RecipeChoosenViewController: UIViewController {

    //#MARK: - Outlet
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var viewAboveBanner: UIView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK: - Button Clicked
    @IBAction func didTouchUpInsideBackButton(_ sender: Any) {
        
    }

}
