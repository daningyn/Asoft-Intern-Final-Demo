//
//  MarketingViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/22/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class MarketingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let titleArray = ["Restaurants", "Bistro", "Home", "Sign in"]
    let detailArray = ["There are many ways food makes people happy and one of the worthiest is a tour that has been described as the \"food lover's dream.\"", "Everyone loves good, old fashioned charcoal grilling. It adds a raw, distinctive taste to your sausages, burgers, ribs, and other grilled items.", "Many people understand the concept of passive solar for heating a home. Fewer realize it can be used in to cook food and sterilize water.", ""]
    let imageArray = ["image-collection-cell-1", "image-collection-cell-2", "image-collection-cell-3", "load-image"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "MarketingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants._IDENTIFIER_MARKETING_COLLECTION_CELL)
        self.collectionView.register(UINib(nibName: "SignInCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants._IDENTIFIER_SIGN_IN_COLLECTION_CELL)
        
        let scroll = UICollectionViewFlowLayout()
        scroll.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = scroll
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x / self.collectionView.bounds.width == 3 {
            self.pageControl.numberOfPages = 0
        } else {
            self.pageControl.numberOfPages = 4
            self.pageControl.currentPage = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if CGFloat(scrollView.contentOffset.x / self.collectionView.bounds.width) > 2.5 {
            self.pageControl.numberOfPages = 0
        }
    }

}


//#MARK: - UICollectionView DataSource
extension MarketingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants._IDENTIFIER_MARKETING_COLLECTION_CELL, for: indexPath) as! MarketingCollectionViewCell
        
            cell.titleLabel.text = self.titleArray[indexPath.row]
            cell.detailLabel.text = self.detailArray[indexPath.row]
            cell.imageView.image = UIImage(named: self.imageArray[indexPath.row])
        
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants._IDENTIFIER_SIGN_IN_COLLECTION_CELL, for: indexPath) as! SignInCollectionViewCell
            

            
            return cell
        }
    }
    
}


//#MARK: - UICollectionView Delegate
extension MarketingViewController: UICollectionViewDelegate {
    
    
    
}


//#MARK: - UICollectionView DelegateFlowLayout
extension MarketingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}








