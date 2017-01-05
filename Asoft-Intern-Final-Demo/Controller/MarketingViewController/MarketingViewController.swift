//
//  MarketingViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/22/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class MarketingViewController: UIViewController {

    //#MARK: - IBOutlet
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var rectangleViewBelow: UIImageView!
    
    //#MARK: - Define Properties
    let titleArray = ["Restaurants", "Bistro", "Home", "Sign in"]
    let detailArray = ["There are many ways food makes people happy and one of the worthiest is a tour that has been described as the \"food lover's dream.\"", "Everyone loves good, old fashioned charcoal grilling. It adds a raw, distinctive taste to your sausages, burgers, ribs, and other grilled items.", "Many people understand the concept of passive solar for heating a home. Fewer realize it can be used in to cook food and sterilize water.", ""]
    let imageArray = ["image-collection-cell-1", "image-collection-cell-2", "image-collection-cell-3", "load-image"]
    lazy var isTrackingImage = false
    lazy var isInSignUpView = false
    
    lazy var cellOnScreen = 0
    lazy var nextCellOnScreen = 1
    
    var btnSignIn: UIButton!
    var btnSignUp: UIButton!
    
    var oneCheck = true
    
    var lineFrame: CGRect = CGRect()
    
    //#MARK: - Set up ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.labelCollectionView.delegate = self
        self.labelCollectionView.dataSource = self
        
        let scroll = UICollectionViewFlowLayout()
        scroll.scrollDirection = .horizontal
        self.imageCollectionView.collectionViewLayout = scroll
        
        AppDelegate.shared.mainColor = self.lineView.backgroundColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.oneCheck {
            self.lineFrame = self.lineView.frame
            self.lineView.translatesAutoresizingMaskIntoConstraints = true
            
            self.oneCheck = false
            self.btnSignIn = UIButton(type: .custom)
            self.view.addSubview(self.btnSignIn)
            self.btnSignIn.frame = CGRect(x: self.view.bounds.width, y: self.view.bounds.height-50, width: self.view.bounds.width, height: 50)
            self.btnSignIn.setTitle("Sign in", for: .normal)
            self.btnSignIn.setTitleColor(UIColor.white, for: .normal)
            self.btnSignIn.backgroundColor = UIColor.untCoralPink
            self.btnSignIn.isHidden = false
            self.btnSignIn.addTarget(self, action: #selector(self.didSignIn), for: .touchUpInside)
            
            self.btnSignUp = UIButton(type: .custom)
            self.view.addSubview(self.btnSignUp)
            self.btnSignUp.frame = CGRect(x: self.view.bounds.width, y: self.view.bounds.height-50, width: self.view.bounds.width, height: 50)
            self.btnSignUp.setTitle("Create Account", for: .normal)
            self.btnSignUp.setTitleColor(UIColor.white, for: .normal)
            self.btnSignUp.backgroundColor = UIColor.untCoralPink
            self.btnSignUp.isHidden = true
        }
    }

    
    //#MARK: - Did select Button In cell
    @IBAction func didTouchSignUpButton(_ sender: Any) {
        self.isInSignUpView = true
        UIView.animate(withDuration: 0.3, animations: {
            self.rectangleViewBelow.frame.size.height = self.labelCollectionView.bounds.height*1.34
            self.rectangleViewBelow.frame.origin.y = self.imageCollectionView.bounds.height*0.4
        }, completion: {(_) in
            self.labelCollectionView.frame = self.rectangleViewBelow.frame
            UIView.animate(withDuration: 0.3, animations: {
                self.labelCollectionView.reloadData()
            }, completion: {(_) in
                UIView.animate(withDuration: 0.3, animations: { 
                    (self.labelCollectionView.cellForItem(at: IndexPath(item: 3, section: 0))!.viewWithTag(1)! as UIView).frame.origin.x = -self.labelCollectionView.bounds.width
                }, completion: {(_) in
                    self.btnSignUp.isHidden = false
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
                self.rectangleViewBelow.frame = self.labelCollectionView.frame
            }, completion: {(_) in
                self.btnSignUp.isHidden = true
            })
        })
    }
    
    func didSignIn() {
        AppDelegate.shared.changeRootViewToHomeVC()
    }
    
    
    //#MARK: - UIScroll Delegate
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if self.isInSignUpView {
            if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) < 2.5 {
                self.isInSignUpView = false
                self.labelCollectionView.reloadData()
            } else {
                
            }
        }
        
//        if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) > 2.5 {
//            self.lineView.isHidden = false
//        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if Int(scrollView.contentOffset.x / self.view.bounds.width) == 3 {
            self.imageCollectionView.isScrollEnabled = false
            self.labelCollectionView.isScrollEnabled = false
            if self.isInSignUpView {
                self.btnSignIn.isHidden = false
                self.btnSignUp.isHidden = true
                self.labelCollectionView.reloadData()
            }
        } else if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) < 2.5 {
            if self.isInSignUpView {
                self.isInSignUpView = false
                self.labelCollectionView.reloadData()
            }
        }

        self.cellOnScreen = Int(scrollView.contentOffset.x / self.imageCollectionView.bounds.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset.x = 0
            self.labelCollectionView.contentOffset.x = 0
            self.imageCollectionView.contentOffset.x = 0
        } else if scrollView.contentOffset.x >= self.imageCollectionView.bounds.width*3 {
            self.imageCollectionView.isScrollEnabled = false
            self.labelCollectionView.isScrollEnabled = false
            scrollView.contentOffset.x = self.imageCollectionView.bounds.width*3
            self.labelCollectionView.contentOffset.x = self.imageCollectionView.bounds.width*3
            self.imageCollectionView.contentOffset.x = self.imageCollectionView.bounds.width*3
        } else {
        
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
//                self.lineView.isHidden = true
            } else {
//                self.lineView.isHidden = false
                self.pageControl.numberOfPages = 4
                self.pageControl.currentPage = Int(scrollView.contentOffset.x / self.imageCollectionView.bounds.width)
            }
        
        }
        
        if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) > CGFloat(self.cellOnScreen) {
            self.nextCellOnScreen = self.cellOnScreen + 1
            
            self.imageCollectionView.cellForItem(at: IndexPath(item: self.nextCellOnScreen, section: 0))?.alpha = CGFloat((scrollView.contentOffset.x - (CGFloat(self.cellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width
            self.imageCollectionView.cellForItem(at: IndexPath(item: self.cellOnScreen, section: 0))?.alpha = 1 - CGFloat((scrollView.contentOffset.x - (CGFloat(self.cellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width
            
            self.labelCollectionView.cellForItem(at: IndexPath(item: self.nextCellOnScreen, section: 0))?.alpha = CGFloat((scrollView.contentOffset.x - (CGFloat(self.cellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width
            self.labelCollectionView.cellForItem(at: IndexPath(item: self.cellOnScreen, section: 0))?.alpha = 1 - CGFloat((scrollView.contentOffset.x - (CGFloat(self.cellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width
            
        } else if CGFloat(scrollView.contentOffset.x / self.imageCollectionView.bounds.width) < CGFloat(self.cellOnScreen) {
            self.nextCellOnScreen = self.cellOnScreen - 1
            
            self.imageCollectionView.cellForItem(at: IndexPath(item: self.cellOnScreen, section: 0))?.alpha = CGFloat((scrollView.contentOffset.x - (CGFloat(self.nextCellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width
            self.imageCollectionView.cellForItem(at: IndexPath(item: self.nextCellOnScreen, section: 0))?.alpha = 1 - CGFloat((scrollView.contentOffset.x - (CGFloat(self.nextCellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width
            
            self.labelCollectionView.cellForItem(at: IndexPath(item: self.cellOnScreen, section: 0))?.alpha = CGFloat((scrollView.contentOffset.x - (CGFloat(self.nextCellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width
            self.labelCollectionView.cellForItem(at: IndexPath(item: self.nextCellOnScreen, section: 0))?.alpha = 1 - CGFloat((scrollView.contentOffset.x - (CGFloat(self.nextCellOnScreen)*self.imageCollectionView.bounds.width))) / self.imageCollectionView.bounds.width

        }
        
        if scrollView.contentOffset.x >= self.imageCollectionView.bounds.width*2 {
            let temp = scrollView.contentOffset.x - self.imageCollectionView.bounds.width*2
            self.btnSignIn.frame.origin.x = self.imageCollectionView.bounds.width - temp
            self.btnSignUp.frame.origin.x = self.btnSignIn.frame.origin.x
            self.lineView.frame.origin.x = self.lineFrame.origin.x - temp
        } else {
            self.btnSignIn.frame.origin.x = self.imageCollectionView.bounds.width
            self.btnSignUp.frame.origin.x = self.btnSignIn.frame.origin.x
            self.lineView.frame = self.lineFrame
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








