//
//  ImageCollectionCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/26/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.delegate = self
        self.mainCollectionView.register(UINib(nibName: "DetailOfImageCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierDetailImageCell)
        self.mainCollectionView.register(UINib(nibName: "HeaderImageCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierHeaderImageCombineCell)
        self.mainCollectionView.register(UINib(nibName: "HeaderImageCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.kIdentifierHeaderImageCombineCell)
    }

}


//#MARK: - UICollectionView DataSource 
extension ImageCollectionCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kCombineNumberRowInSection[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierDetailImageCell, for: indexPath)
        
        (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kCombineImageCellArray[indexPath.row % 3])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = self.mainCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.kIdentifierHeaderImageCombineCell, for: indexPath)
        
        
        
        return headerView
    }
    
}


//#MARK: - UICollectionView Delegate 
extension ImageCollectionCell: UICollectionViewDelegate {
    
    
    
}


//#MARK: - UICollectionView Delegate FlowLayout
extension ImageCollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width-28)/3, height: (collectionView.bounds.width-20)/3)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 45)
    }
    
}








