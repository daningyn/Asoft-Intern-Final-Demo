//
//  CombineView.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/24/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class CombineView: UIView {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var footerMenu: UIView!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var botView: UIView!
    
    var selectedCell: Int = 0
    var menu = ["IMAGES", "NAMES"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}


//#MARK: - ScrollDetailCollectionViewDelegate
extension CombineView: ScrollDetailCollectionViewDelegate {
    
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
        self.footerMenu.frame.origin.x = CGFloat(CGFloat(selectedCell)*(self.menuCollectionView.bounds.width/2))
        self.detailCollectionView.reloadData()
    }
    
    func setContentOffsetYToTopForBotView() {
        self.topView.frame.origin.y = 1 - self.topView.frame.size.height
        self.botView.frame.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height
        self.botView.frame.size.height = self.frame.size.height - 1
        self.detailCollectionView.frame.origin.y = self.menuCollectionView.frame.origin.y + 50
        self.detailCollectionView.frame.size.height = self.botView.frame.size.height - 50
        self.detailCollectionView.reloadData()
    }
    
    func setContentOffsetYToTopForTopView() {
        self.topView.frame.origin.y = 0
        self.botView.frame.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height
        self.botView.frame.size.height = self.frame.size.height - self.topView.frame.size.height
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


//#MARK: - UICollectionView DataSource
extension CombineView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case menuCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierCombineMenuViewCell, for: indexPath) as! MenuCollectionCell
            
            if indexPath.row == selectedCell {
                cell.textLabel.textColor = UIColor.black
                UIView.animate(withDuration: 0.2, animations: {
                    self.footerMenu.frame.origin.x = cell.frame.origin.x
                })
            } else {
                if let color = AppDelegate.shared.mainColor {
                    cell.textLabel.textColor = color
                }
            }
            cell.textLabel.text = menu[indexPath.row]
            
            return cell
        default:
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierImageCollectionViewCell, for: indexPath) as! ImageCollectionCell
                
                cell.animationDelegate = self
                
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierNameCollectionViewCell, for: indexPath) as! NameCollectionCell
                
                cell.animationDelegate = self
                
                return cell
            }
        }
        
    }
    
}


//#MARK: UICollectionView Delegate
extension CombineView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case menuCollectionView:
            self.selectedCell = indexPath.row
            self.menuCollectionView.reloadData()
            UIView.animate(withDuration: 0.3, animations: {
                self.detailCollectionView.contentOffset.x = self.detailCollectionView.bounds.width*CGFloat(self.selectedCell)
            })
        default:
            break
        }
    }
    
}


//#MARK: - UICollectionView Delegate FlowLayout
extension CombineView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case menuCollectionView:
            return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.height-3)
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


//#MARK: - Scroll View Delegate
extension CombineView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.footerMenu.frame.origin.x = self.detailCollectionView.contentOffset.x/2
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.selectedCell = Int(scrollView.contentOffset.x / self.detailCollectionView.bounds.width)
        self.menuCollectionView.reloadData()
    }
    
}



