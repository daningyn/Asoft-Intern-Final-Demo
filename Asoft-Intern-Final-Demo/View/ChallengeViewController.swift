//
//  ChallengeViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/30/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {

    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    var initializer = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AppDelegate.shared.homeNavigation.navigationItem.rightBarButtonItem = nil
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kChallengeNavigationTitle
        
        let layout = ChallengeCustomFlowLayout()
        self.slideCollectionView.collectionViewLayout = layout
        self.slideCollectionView.dataSource = self
        self.slideCollectionView.delegate = self
        
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//#MARK: - UICollectionView DataSource
extension ChallengeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.slideCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierChallengeCollectionViewCell, for: indexPath)
            
            (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kCombineImageCellArray[indexPath.row % 3])
            (cell.viewWithTag(1) as! UIImageView).clipsToBounds = true
            (cell.viewWithTag(1) as! UIImageView).layer.cornerRadius = 5
            (cell.viewWithTag(1) as! UIImageView).layer.borderWidth = 0.2
            (cell.viewWithTag(1) as! UIImageView).layer.borderColor = UIColor.untCoralPink.cgColor
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierDetailChallengeCollectionViewCell, for: indexPath)
            return cell
        }
    }
    
}


//#MARK: - UICollectionView Delegate
extension ChallengeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.initializer {
            self.initializer = false
            self.slideCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
//            self.detailCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
}


//#MARK: - UICollectionView Delegate FlowLayout
extension ChallengeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.slideCollectionView:
            return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
        default:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


//#MARK: - UIScrollView Delegate
extension ChallengeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.slideCollectionView as UIScrollView == scrollView {
            let contentX = (self.detailCollectionView.bounds.width*scrollView.contentOffset.x) / self.slideCollectionView.bounds.height
            self.detailCollectionView.contentOffset.x = contentX
        }
    }
}







