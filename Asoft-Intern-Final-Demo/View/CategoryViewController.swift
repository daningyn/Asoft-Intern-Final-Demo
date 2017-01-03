//
//  CategoryViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/3/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    //#MARK: - Outlet
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var botView: UIView!
    
    //#MARK: - Define properties
    var btnBarFilter = UIBarButtonItem()
    var selectedCell = 0
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconFilter), for: .normal)
        button.addTarget(self, action: #selector(self.didTouchUpButtonFilter), for: .touchUpInside)
        btnBarFilter = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = btnBarFilter
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kCategoryNavigationTitle
        
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.delegate = self
        self.detailCollectionView.translatesAutoresizingMaskIntoConstraints = true
        self.footerView.translatesAutoresizingMaskIntoConstraints = true
        self.botView.translatesAutoresizingMaskIntoConstraints = true
        self.topView.translatesAutoresizingMaskIntoConstraints = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK: - Define function bar button
    func didTouchUpButtonFilter() {
        
    }

}


//#MARK: - UICollectionView DataSource 
extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kCategoryMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.menuCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierCategoryMenuCollectionViewCell, for: indexPath)
            
            (cell.viewWithTag(1) as! UILabel).text = AppResourceIdentifiers.kCategoryMenuArray[indexPath.row]
            if indexPath.row == self.selectedCell {
                (cell.viewWithTag(1) as! UILabel).textColor = UIColor.black
            } else {
                (cell.viewWithTag(1) as! UILabel).textColor = UIColor.untCoralPink
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierCategoryDetailCollectionViewCell, for: indexPath) as! CategoryDetailCollectionViewCell
            
            cell.animationDelegate = self
            
            return cell
        }
    }
    
}


//#MARK: - UICollectionView Delegate
extension CategoryViewController: UICollectionViewDelegate {
    
    
    
}


//#MARK: - UICollectionView DelegateFlowLayout
extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.menuCollectionView:
            return CGSize(width: collectionView.bounds.width/4, height: collectionView.bounds.height)
        default:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
    
}


//#MARK: - UIScrollView Delegate
extension CategoryViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.detailCollectionView as UIScrollView == scrollView {
            self.footerView.frame.origin.x = scrollView.contentOffset.x*self.footerView.bounds.width/self.detailCollectionView.bounds.width
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
extension CategoryViewController: ScrollDetailCollectionViewDelegate {
    
    func getContentOffsetYCombineTopView() -> CGFloat {
        return self.topView.frame.origin.y
    }
    
    func getHeightCombineTopView() -> CGFloat {
        return self.topView.frame.size.height
    }
    
    func subtractionView(value: CGFloat) {
        self.topView.frame.origin.y -= value
        self.botView.frame.origin.y -= value
    }
    
    func plusHeightForBotView(value: CGFloat) {
        self.botView.frame.size.height += value
    }
    
    func setHeightForDetailCollectionView() {
        self.detailCollectionView.frame.size.height = self.botView.frame.size.height - 50
        self.footerView.frame.origin.x = CGFloat(CGFloat(selectedCell)*(self.menuCollectionView.bounds.width/4))
        self.detailCollectionView.reloadData()
    }
    
    func setContentOffsetYToTopForBotView() {
        self.topView.frame.origin.y = 65 - self.topView.frame.size.height
        self.botView.frame.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height
        self.botView.frame.size.height = self.view.frame.size.height - 65
        self.detailCollectionView.frame.origin.y = self.menuCollectionView.frame.origin.y + 50
        self.detailCollectionView.frame.size.height = self.botView.frame.size.height - 50
        self.detailCollectionView.reloadData()
    }
    
    func setContentOffsetYToTopForTopView() {
        self.topView.frame.origin.y = 64
        self.botView.frame.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height
        self.botView.frame.size.height = self.view.frame.size.height - self.topView.frame.size.height - 64
        self.detailCollectionView.frame.origin.y = self.menuCollectionView.frame.origin.y + 50
        self.detailCollectionView.frame.size.height = self.botView.frame.size.height - 50
        self.detailCollectionView.reloadData()
    }
    
    func plusContentForView(value: CGFloat) {
        self.topView.frame.origin.y += value
        self.botView.frame.origin.y += value
    }
    
    func reloadCollectionViewData() {
        self.detailCollectionView.reloadData()
    }
    
}










