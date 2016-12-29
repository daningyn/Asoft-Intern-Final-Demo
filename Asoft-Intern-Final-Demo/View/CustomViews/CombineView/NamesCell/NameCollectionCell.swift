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
    
    var animationDelegate: ScrollDetailCollectionViewDelegate?
    
    lazy internal var myContentOffsetY: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.delegate = self
        self.mainCollectionView.register(UINib(nibName: "DetailOfNameCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierDetailNamesCell)
        self.mainCollectionView.register(UINib(nibName: "HeaderImageCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.kIdentifierHeaderImageCombineCell)
    }

}


//#MARK: - UICollectionView DataSource
extension NameCollectionCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return AppResourceIdentifiers.kCombineHeaderInSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kCombineNumberRowInSection[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierDetailNamesCell, for: indexPath)
        
        (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kCombineImageCellArray[indexPath.row % 3])
        (cell.viewWithTag(1) as! UIImageView).layer.borderWidth = 0.2
        (cell.viewWithTag(1) as! UIImageView).layer.borderColor = UIColor.untCoralPink.cgColor
        (cell.viewWithTag(1) as! UIImageView).layer.cornerRadius = 5.0
        (cell.viewWithTag(1) as! UIImageView).clipsToBounds = true
        (cell.viewWithTag(2) as! UILabel).text = AppResourceIdentifiers.kCombineTitlteNamesCellArray[indexPath.row % 3]
        (cell.viewWithTag(3) as! UILabel).text = AppResourceIdentifiers.kCombineDetailNamesCellArray[indexPath.row % 3]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = self.mainCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.kIdentifierHeaderImageCombineCell, for: indexPath)
        
        (headerView.viewWithTag(1) as! UILabel).text = AppResourceIdentifiers.kCombineHeaderInSection[indexPath.section]
        (headerView.viewWithTag(2) as! UILabel).text = "\(AppResourceIdentifiers.kCombineNumberRowInSection[indexPath.section])"
        
        return headerView
    }
    
}


//#MARK: - UICollectionView Delegate
extension NameCollectionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppDelegate.shared.homeNavigation.viewControllers[0].performSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueToCombineResultVC, sender: nil)
    }
    
}


//#MARK: - UICollectionView DelegateFlowLayout
extension NameCollectionCell: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: (collectionView.bounds.width)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 35)
    }
    
}


//#MARK: - UIScrollView Delegate
extension NameCollectionCell {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < scrollView.contentSize.height -  scrollView.frame.size.height {
            if scrollView.contentOffset.y > self.myContentOffsetY {
                if let animationDelegate = self.animationDelegate {
                    if animationDelegate.getContentOffsetYCombineTopView() > 1 - animationDelegate.getHeightCombineTopView() {
                        animationDelegate.subtractionView(value: scrollView.contentOffset.y - self.myContentOffsetY)
                        animationDelegate.plusHeightForBotView(value: scrollView.contentOffset.y - self.myContentOffsetY)
                        animationDelegate.setHeightForDetailCollectionView()
                    } else {
                        animationDelegate.setContentOffsetYToTopForBotView()
                    }
                    self.myContentOffsetY = scrollView.contentOffset.y
                }
            } else {
                if let animationDelegate = self.animationDelegate {
                    if animationDelegate.getContentOffsetYCombineTopView() >= 0 {
                        animationDelegate.setContentOffsetYToTopForTopView()
                    } else {
                        animationDelegate.plusContentForView(value: self.myContentOffsetY - scrollView.contentOffset.y)
                        animationDelegate.plusHeightForBotView(value: scrollView.contentOffset.y - self.myContentOffsetY)
                        animationDelegate.setHeightForDetailCollectionView()
                    }
                    self.myContentOffsetY = scrollView.contentOffset.y
                }
            }
        } else {
            if let animationDelegate = self.animationDelegate {
                animationDelegate.reloadCollectionViewData()
            }
        }
    }
    
}






