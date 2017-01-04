//
//  RecipeChoosenViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/4/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class RecipeChoosenViewController: UIViewController {

    //#MARK: - Outlet
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet weak var viewAboveBanner: UIView!
    @IBOutlet private weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var botView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    //#MARK: - Define properties
    var selectedCell = 0
    var bannerImage: String?
    var navigationTitle: String?
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        self.menuCollectionView.register(UINib(nibName: "MenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierCombineMenuViewCell)
        
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.delegate = self
        
        self.footerView.translatesAutoresizingMaskIntoConstraints = true
        
        if let bannerImage = self.bannerImage {
            self.bannerImageView.image = UIImage(named: bannerImage)
        }
        if let navigationTitle = self.navigationTitle {
            self.navigationTitleLabel.text = navigationTitle
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK: - Button Clicked
    @IBAction func didTouchUpInsideBackButton(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }

}


//#MARK: - UICollectionView DataSource
extension RecipeChoosenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kRecipeChoosenMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.menuCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierCombineMenuViewCell, for: indexPath) as! MenuCollectionCell
            
            cell.textLabel.text = AppResourceIdentifiers.kRecipeChoosenMenuArray[indexPath.row]
            if indexPath.row == self.selectedCell {
                cell.textLabel.textColor = UIColor.black
            } else {
                cell.textLabel.textColor = UIColor.untCoralPink
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierRecipeChoosenCollectionViewCell, for: indexPath) as! RecipeChoosenCollectionViewCell
            
            if indexPath.row == 0 {
                cell.haveButton = false
            } else {
                cell.haveButton = true
            }
            
            return cell
        }
    }
    
}


//#MARK: - UICollectionView Delegate
extension RecipeChoosenViewController: UICollectionViewDelegate {
    
    
    
}


//#MARK: - UICollectionView DelegateFlowLayout
extension RecipeChoosenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.menuCollectionView:
            return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.height)
        default:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
    
}


//#MARK: - UIScrollView Delegate 
extension RecipeChoosenViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.detailCollectionView as UIScrollView == scrollView {
            self.footerView.frame.origin.x = scrollView.contentOffset.x/2
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.detailCollectionView as UIScrollView == scrollView {
            self.selectedCell = Int(scrollView.contentOffset.x/self.detailCollectionView.bounds.width)
            self.menuCollectionView.reloadData()
        }
    }
    
}









