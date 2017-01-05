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
    var ratioAlpha: CGFloat = 0
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        self.menuCollectionView.register(UINib(nibName: "MenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierCombineMenuViewCell)
        
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.delegate = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.footerView.translatesAutoresizingMaskIntoConstraints = true
        self.viewAboveBanner.translatesAutoresizingMaskIntoConstraints = true
        self.botView.translatesAutoresizingMaskIntoConstraints = true
        self.detailCollectionView.translatesAutoresizingMaskIntoConstraints = true
        
        self.ratioAlpha = CGFloat(0.8 / (self.viewAboveBanner.bounds.height - 64))
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
            
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierRecipeChoosenFirstCollectionViewCell, for: indexPath) as! RecipeChoosenCollectionViewCell
                cell.haveButton = false
                cell.animationDelegate = self
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierRecipeChoosenSecondCollectionViewCell, for: indexPath) as! RecipeChoosenCollectionViewCell
                cell.haveButton = true
                cell.animationDelegate = self
                
                return cell
            }
            
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


//#MARK: - ScrollDetailCollectionViewDelegate
extension RecipeChoosenViewController: ScrollDetailCollectionViewDelegate {
    
    func getContentOffsetYCombineTopView() -> CGFloat {
        return self.viewAboveBanner.frame.origin.y
    }
    
    func getHeightCombineTopView() -> CGFloat {
        return self.viewAboveBanner.bounds.height
    }
    
    func subtractionView(value: CGFloat) {
        self.viewAboveBanner.frame.origin.y -= value
        self.botView.frame.origin.y -= value
        self.viewAboveBanner.alpha += value*self.ratioAlpha
    }
    
    func plusHeightForBotView(value: CGFloat) {
        self.botView.frame.size.height += value
    }
    
    func setHeightForDetailCollectionView() {
        self.detailCollectionView.frame.size.height = self.botView.frame.size.height - 50
        self.footerView.frame.origin.x = CGFloat(CGFloat(selectedCell)*(self.menuCollectionView.bounds.width/2))
        self.detailCollectionView.reloadData()
    }
    func setContentOffsetYToTopForBotView() {
        self.viewAboveBanner.frame.origin.y = 65 - self.viewAboveBanner.frame.size.height
        self.botView.frame.origin.y = self.viewAboveBanner.frame.origin.y + self.viewAboveBanner.frame.size.height
        self.botView.frame.size.height = self.view.frame.size.height - 65
        self.detailCollectionView.frame.origin.y = self.menuCollectionView.frame.origin.y + 50
        self.detailCollectionView.frame.size.height = self.botView.frame.size.height - 50
        self.viewAboveBanner.alpha = 0.8
        self.detailCollectionView.reloadData()
    }
    
    func setContentOffsetYToTopForTopView() {
        self.viewAboveBanner.frame.origin.y = 0
        self.botView.frame.origin.y = self.viewAboveBanner.frame.origin.y + self.viewAboveBanner.frame.size.height
        self.botView.frame.size.height = self.view.frame.size.height - self.viewAboveBanner.frame.size.height
        self.detailCollectionView.frame.origin.y = self.menuCollectionView.frame.origin.y + 50
        self.detailCollectionView.frame.size.height = self.botView.frame.size.height - 50
        self.viewAboveBanner.alpha = 0
        self.detailCollectionView.reloadData()
    }
    
    func plusContentForView(value: CGFloat) {
        self.viewAboveBanner.frame.origin.y += value
        self.botView.frame.origin.y += value
        self.viewAboveBanner.alpha -= value*ratioAlpha
    }
    
    func reloadCollectionViewData() {
        self.detailCollectionView.reloadData()
    }
    
}









