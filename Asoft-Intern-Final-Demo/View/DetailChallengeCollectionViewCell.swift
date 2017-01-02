//
//  DetailChallengeCollectionViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/2/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class DetailChallengeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
    }
    
}


//#MARK: - UITableView DataSource
extension DetailChallengeCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierDetailTableViewCellInChallengeCollectionViewCell, for: indexPath)
        
        (cell.viewWithTag(1) as! UILabel).text = AppResourceIdentifiers.kDetailPlanningRecipes[indexPath.row]
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension DetailChallengeCollectionViewCell: UITableViewDelegate {
    
    
    
}









