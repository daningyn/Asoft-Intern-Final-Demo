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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierChallengeCollectionViewCell, for: indexPath)
        
        (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kCombineImageCellArray[indexPath.row % 3])
        
        return cell
    }
    
}


//#MARK: - UICollectionView Delegate
extension ChallengeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}









