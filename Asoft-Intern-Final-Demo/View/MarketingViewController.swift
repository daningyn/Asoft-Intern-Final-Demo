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
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var rectangleViewBelow: UIImageView!
    
    let titleArray = ["Restaurants", "Bistro", "Home", "Sign in"]
    let detailArray = ["There are many ways food makes people happy and one of the worthiest is a tour that has been described as the \"food lover's dream.\"", "Everyone loves good, old fashioned charcoal grilling. It adds a raw, distinctive taste to your sausages, burgers, ribs, and other grilled items.", "Many people understand the concept of passive solar for heating a home. Fewer realize it can be used in to cook food and sterilize water.", ""]
    let imageArray = ["image-collection-cell-1", "image-collection-cell-2", "image-collection-cell-3", "load-image"]
    lazy var isTrackingImage = false
    lazy var isInSignUpView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.labelCollectionView.delegate = self
        self.labelCollectionView.dataSource = self
        
        let scroll = UICollectionViewFlowLayout()
        scroll.scrollDirection = .horizontal
        self.imageCollectionView.collectionViewLayout = scroll
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //#MARK: - Did select Button In cell
    @IBAction func didTouchSignUpButton(_ sender: Any) {
        self.isInSignUpView = true
        UIView.animate(withDuration: 0.2, animations: {
            self.rectangleViewBelow.frame.size.height = self.labelCollectionView.bounds.height*1.34
            self.rectangleViewBelow.frame.origin.y = self.imageCollectionView.bounds.height*0.4
        }, completion: {(_) in
            self.labelCollectionView.frame.origin.y = self.imageCollectionView.bounds.height*0.4
            self.labelCollectionView.frame.size.height = self.labelCollectionView.bounds.height*1.34
            UIView.animate(withDuration: 0.3, animations: {
                self.labelCollectionView.reloadData()
            }, completion: {(_) in
                UIView.animate(withDuration: 0.2, animations: {
                    (self.labelCollectionView.cellForItem(at: IndexPath(item: 3, section: 0))!.viewWithTag(1)! as UIView).frame.origin.x = -self.labelCollectionView.bounds.width
                })
            })
            
        })
    }
    
    @IBAction func didTouchSignInInCreateAccount(_ sender: Any) {
        self.isInSignUpView = false
        self.labelCollectionView.frame.origin.y = self.imageCollectionView.bounds.height*0.55
        self.labelCollectionView.frame.size.height = self.imageCollectionView.bounds.height*0.45
        UIView.animate(withDuration: 0.3, animations: {
            (self.labelCollectionView.cellForItem(at: IndexPath(item: 3, section: 0))!.viewWithTag(1)! as UIView).frame.origin.x = 0
        }, completion: {(_) in
            self.labelCollectionView.reloadData()
            UIView.animate(withDuration: 0.3, animations: {
                self.rectangleViewBelow.frame.size.height = self.imageCollectionView.bounds.height*0.45
                self.rectangleViewBelow.frame.origin.y = self.imageCollectionView.bounds.height*0.55
            })
        })
    }
    
    @IBAction func didSignIn(_ sender: Any) {
        AppDelegate.shared.changeRootViewToHomeVC()
    }
    
    
    //#MARK: - UIScroll Delegate
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if self.isInSignUpView {
            if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) < 2.5 {
                self.isInSignUpView = false
                self.labelCollectionView.reloadData()
            }
        }
        
        if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) > 2.5 {
            self.lineView.isHidden = false
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.isInSignUpView {
            if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) < 2.5 {
                self.isInSignUpView = false
                self.labelCollectionView.reloadData()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset.x = 0
        } else if scrollView.contentOffset.x >= self.imageCollectionView.bounds.width*3 {
            scrollView.contentOffset.x = self.imageCollectionView.bounds.width*3
        }
        
        if self.imageCollectionView.isTracking == true {
            self.isTrackingImage = true
            self.labelCollectionView.contentOffset.x = self.imageCollectionView.contentOffset.x
        } else if self.labelCollectionView.isTracking == true {
            self.isTrackingImage = false
            self.imageCollectionView.contentOffset.x = self.labelCollectionView.contentOffset.x
        }
        if self.isTrackingImage {
            self.labelCollectionView.contentOffset.x = self.imageCollectionView.contentOffset.x
        } else {
            self.imageCollectionView.contentOffset.x = self.labelCollectionView.contentOffset.x
        }
        
        if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) > 2.5 {
            self.pageControl.numberOfPages = 0
            self.lineView.isHidden = true
        } else {
            self.lineView.isHidden = false
            self.pageControl.numberOfPages = 4
            self.pageControl.currentPage = Int(scrollView.contentOffset.x / self.imageCollectionView.bounds.width)
        }
        
    }

}


//#MARK: - UICollectionView DataSource
extension MarketingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.imageCollectionView:
            if indexPath.row != 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierMarketingCollectionCell, for: indexPath)
                
                (cell.viewWithTag(1) as! UIImageView).image = UIImage(named: self.imageArray[indexPath.row])
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierMarketingImageSignInCollectionCell, for: indexPath)
                
                return cell
            }
        default:
            if indexPath.row != 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierMarketingLabelCollectionCell, for: indexPath)
                
                (cell.viewWithTag(1) as! UILabel).text = self.titleArray[indexPath.row]
                (cell.viewWithTag(2) as! UILabel).text = self.detailArray[indexPath.row]
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierMarketingLabelSignInCollectionCell, for: indexPath)
                
                AppDelegate.shared.mainColor = (cell.viewWithTag(99) as! UIButton).backgroundColor
                
              return cell
            }
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

//#MARK: Button Click
extension MarketingViewController {
    
    
    
}








