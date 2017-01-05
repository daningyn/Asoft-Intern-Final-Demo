//
//  FavoriteViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/5/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    //#MARK: - Outlet
    @IBOutlet weak var mainTableView: UITableView!
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()

        AppDelegate.shared.homeNavigation.navigationItem.rightBarButtonItem = nil
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kFavoriteNavigationTitle
        
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//#MARK: - UITableView DataSource
extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kFavoriteImageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierFavoriteTableViewCell, for: indexPath) as! FavoriteTableViewCell
        
        cell.selectionStyle = .none
        cell.containerView.clipsToBounds = true
        cell.containerView.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 1
        cell.mainImageView.image = UIImage(named: AppResourceIdentifiers.kFavoriteImageArray[indexPath.row])
        cell.nameLabel.text = AppResourceIdentifiers.kFavoriteNameArray[indexPath.row]
        cell.timeLabel.text = AppResourceIdentifiers.kFavoriteTimeArray[indexPath.row]
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}















