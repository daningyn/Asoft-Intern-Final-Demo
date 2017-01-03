//
//  CategoryDetailCollectionViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/3/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class CategoryDetailCollectionViewCell: UICollectionViewCell {
    
    //#MARK: - Outlet
    @IBOutlet weak var mainTableView: UITableView!
    
    //#MARK: - Define properties
    
    //#MARK: - Set up
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
}


//#MARK: - UITableView DataSource
extension CategoryDetailCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierCategoryCustomDetailTableViewCell, for: indexPath)
    
        cell.viewWithTag(1)?.clipsToBounds = true
        cell.viewWithTag(1)?.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 1
        
        (cell.viewWithTag(2) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kCategoryImageArray[indexPath.row % 3])
        (cell.viewWithTag(3) as! UILabel).text = AppResourceIdentifiers.kCategoryNameArray[indexPath.row % 3]
        (cell.viewWithTag(4) as! UILabel).text = AppResourceIdentifiers.kCategoryTimeArray[indexPath.row % 3]
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension CategoryDetailCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 2.5
    }
    
}










