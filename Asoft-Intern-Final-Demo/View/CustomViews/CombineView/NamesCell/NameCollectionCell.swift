//
//  NameCollectionCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/26/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class NameCollectionCell: UICollectionViewCell {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.delegate = self
    }

}


//#MARK: - UICollectionView DataSource
extension NameCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kCombineNumberRowInSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
}


//#MARK: - UICollectionView Delegate
extension NameCollectionCell: UICollectionViewDelegate {
    
    
    
}






