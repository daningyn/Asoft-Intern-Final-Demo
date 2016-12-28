//
//  CombineResultViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/28/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class CombineResultViewController: UIViewController {

    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultCollectionView.dataSource = self
        resultCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//#MARK: - UICollectionView DataSource
extension CombineResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kCombineNumberRowInSection[0]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierCombineResultCollectionViewCell, for: indexPath)
        
        (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kCombineImageCellArray[indexPath.row % 3])
        (cell.viewWithTag(1) as! UIImageView).clipsToBounds = true
        (cell.viewWithTag(1) as! UIImageView).layer.cornerRadius = 5
        (cell.viewWithTag(1) as! UIImageView).layer.borderWidth = 0.2
        (cell.viewWithTag(1) as! UIImageView).layer.borderColor = UIColor.untCoralPink.cgColor
        
        return cell
    }
    
}


//#MARK: - UICollectionView Delegate
extension CombineResultViewController: UICollectionViewDelegate {
    
    
    
}


//#MARK: - UICollectionView DelegateFlowLayout
extension CombineResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width-20)/3, height: (collectionView.bounds.width-20)/3)
    }
    
}







