//
//  ChefQuoteCollectionViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/30/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class ChefQuoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        self.detailTableView.rowHeight = UITableViewAutomaticDimension
        self.detailTableView.estimatedRowHeight = 150
    }
    
}


//#MARK: - UITableView DataSource
extension ChefQuoteCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return AppResourceIdentifiers.kChefQuoteNumberHeart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierChefVideoQuoteDetailTableViewCell, for: indexPath)
        
        cell.viewWithTag(100)!.clipsToBounds = true
        cell.viewWithTag(100)!.layer.cornerRadius = 2
        (cell.viewWithTag(1) as! UILabel).text = AppResourceIdentifiers.kChefQuoteDetailTextArray[indexPath.row % AppResourceIdentifiers.kChefQuoteDetailTextArray.count]
        (cell.viewWithTag(2) as! UILabel).text = AppResourceIdentifiers.kChefQuoteAddressArray[indexPath.row % AppResourceIdentifiers.kChefQuoteAddressArray.count]
        (cell.viewWithTag(3) as! UILabel).text = "\(AppResourceIdentifiers.kChefQuoteNumberHeart[indexPath.row % AppResourceIdentifiers.kChefQuoteNumberHeart.count])"
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension ChefQuoteCollectionViewCell: UITableViewDelegate {
    
    
    
}









