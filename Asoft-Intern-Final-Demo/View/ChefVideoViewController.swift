//
//  ChefVideoViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/29/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class ChefVideoViewController: UIViewController {
    
    //#MARK: - Outlet
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var footerMenu: UIView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    //#MARK: - Define properties
    lazy var currentChefs = 0
    var menuArray = ["VIDEO", "QUOTES"]
    var valueThumbLabel: UILabel = UILabel()
    var oneCheck = true
    var initializer = true
    var isPlay = true
    var selectedCell = 0
    
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.untDarkGreyBackground
        self.navigationTitle.text = AppResourceIdentifiers.kChefVideoChefArray[self.currentChefs]
        
        self.valueThumbLabel.backgroundColor = UIColor.clear
        self.valueThumbLabel.textColor = UIColor.white
        
        self.menuCollectionView.delegate = self
        self.menuCollectionView.dataSource = self
        
        self.detailCollectionView.delegate = self
        self.detailCollectionView.dataSource = self
        
        self.footerMenu.translatesAutoresizingMaskIntoConstraints = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.initializer {
            let cell = self.detailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))!
            let trackRect = (cell.viewWithTag(2) as! UISlider).trackRect(forBounds: (cell.viewWithTag(2) as! UISlider).bounds)
            let thumbRect =  (cell.viewWithTag(2) as! UISlider).thumbRect(forBounds: (cell.viewWithTag(2) as! UISlider).bounds, trackRect: trackRect, value: (cell.viewWithTag(2) as! UISlider).value)
            (cell.viewWithTag(3)! as UIView).addSubview(self.valueThumbLabel)
            self.valueThumbLabel.frame.origin.x = thumbRect.origin.x + (cell.viewWithTag(2) as! UISlider).frame.origin.x + 2
            self.valueThumbLabel.frame.origin.y = (cell.viewWithTag(4) as! UILabel).frame.origin.y
            self.valueThumbLabel.text = "\(Double((cell.viewWithTag(2) as! UISlider).value).roundTo(places: 2))"
        }
    }
    
    //#MARK: - UISlider ValueChanged
    func valueChangedSlider() {
        let cell = self.detailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))!
        let trackRect = (cell.viewWithTag(2) as! UISlider).trackRect(forBounds: (cell.viewWithTag(2) as! UISlider).bounds)
        let thumbRect =  (cell.viewWithTag(2) as! UISlider).thumbRect(forBounds: (cell.viewWithTag(2) as! UISlider).bounds, trackRect: trackRect, value: (cell.viewWithTag(2) as! UISlider).value)
        self.valueThumbLabel.frame.origin.x = thumbRect.origin.x + (cell.viewWithTag(2) as! UISlider).frame.origin.x + 2
        self.valueThumbLabel.frame.origin.y = (cell.viewWithTag(4) as! UILabel).frame.origin.y
        self.valueThumbLabel.text = "\(Double((cell.viewWithTag(2) as! UISlider).value).roundTo(places: 2))"
        
    }
    
    
    //#MARK: - Clicked Button
    @IBAction func didTouchUpBackButton(_ sender: Any) {
        AppDelegate.shared.homeNavigation.popViewController(animated: true)
    }
    
    @IBAction func didTouchUpPause(_ sender: Any) {
        let cell = self.detailCollectionView.cellForItem(at: IndexPath(item: 0, section: 0))!
        if self.isPlay {
            UIView.animate(withDuration: 0.2, animations: {
                (cell.viewWithTag(5) as! UIButton).layer.opacity = 0.1
            }, completion: {(_) in
                (cell.viewWithTag(5) as! UIButton).setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconPlay), for: .normal)
                UIView.animate(withDuration: 0.2, animations: { 
                    (cell.viewWithTag(5) as! UIButton).layer.opacity = 1
                })
            })
            self.isPlay = !self.isPlay
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                (cell.viewWithTag(5) as! UIButton).layer.opacity = 0.1
            }, completion: {(_) in
                (cell.viewWithTag(5) as! UIButton).setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconPause), for: .normal)
                UIView.animate(withDuration: 0.2, animations: {
                    (cell.viewWithTag(5) as! UIButton).layer.opacity = 1
                })
            })
            self.isPlay = !self.isPlay
        }
    }

}


//#MARK: - UIScrollView Delegate
extension ChefVideoViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.footerMenu.frame.origin.x = self.detailCollectionView.contentOffset.x/2
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.selectedCell = Int(scrollView.contentOffset.x / self.detailCollectionView.bounds.width)
        self.menuCollectionView.reloadData()
    }
    
}


//#MARK: - UIColelctionView DataSource 
extension ChefVideoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.menuCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierChefVideoMenuCollectionCell, for: indexPath)
            
            (cell.viewWithTag(1) as! UILabel).text = self.menuArray[indexPath.row]
            if self.selectedCell == indexPath.row {
                (cell.viewWithTag(1) as! UILabel).textColor = UIColor.white
            } else {
                (cell.viewWithTag(1) as! UILabel).textColor = AppDelegate.shared.mainColor
            }
            
            return cell
        default:
            
            
            switch indexPath.row{
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierChefVideoControlDetailCollectionCell, for: indexPath)
                
                (cell.viewWithTag(1) as! UIButton).imageView?.contentMode = .scaleAspectFill
                (cell.viewWithTag(1) as! UIButton).setImage(UIImage(named: AppResourceIdentifiers.kChefVideoImageChefArray[self.currentChefs]), for: .normal)
                
                if self.oneCheck {
                    self.oneCheck = false
                    self.valueThumbLabel.frame.size = CGSize(width: 60, height: 20)
                    self.valueThumbLabel.font = UIFont(name: self.valueThumbLabel.font.fontName, size: 12)
                    self.valueThumbLabel.textColor = UIColor.init(netHex: 0x9B9B9B)
                    
                    (cell.viewWithTag(2) as! UISlider).addTarget(self, action: #selector(self.valueChangedSlider), for: .valueChanged)
                }
                
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierChefVideoQuoteDetailCollectionCell, for: indexPath) as! ChefQuoteCollectionViewCell
                
                
                
                return cell
            }
            
            
            
        }
    }
    
}


//#MARK: - UICollectionView Delegate
extension ChefVideoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case menuCollectionView:
            self.selectedCell = indexPath.row
            self.detailCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.menuCollectionView.reloadData()
        default:
            break
        }
    }
    
}


//#MARK: - UICollectionView DelegateFlowLayout
extension ChefVideoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.menuCollectionView:
            return CGSize(width: collectionView.bounds.width/2, height: 50)
        default:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
    
}








