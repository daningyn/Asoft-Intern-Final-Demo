//
//  RecipeChoosenCollectionViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/4/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class RecipeChoosenCollectionViewCell: UICollectionViewCell {
    
    //#MARK: - Outlet
    @IBOutlet weak var mainTableView: UITableView!
    
    //#MARK: - Define properties
    var haveButton = false
    var animationDelegate: ScrollDetailCollectionViewDelegate?
    var myContentOffsetY: CGFloat = 0
    var currentFood: Food?
    
    //#MARK: - Set up
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mainTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        self.mainTableView.estimatedRowHeight = 150
        
    }
    
}


//#MARK: - UITableView DataSource
extension RecipeChoosenCollectionViewCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.haveButton {
            if let currentFood = self.currentFood {
                return currentFood.directionHeader.count + 1
            } else {
                return 0
            }
        } else {
            if let currentFood = self.currentFood {
                return currentFood.ingridientHeader.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.haveButton {
            if section == 0 {
                return 1
            } else {
                return self.currentFood!.directionDetail[section-1].count
            }
        } else {
            return self.currentFood!.ingridientDetail[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.haveButton {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierRecipeChoosenButtonTableViewCell, for: indexPath) as! RecipeChoosenButtonTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierRecipeChoosenTextTableViewCell, for: indexPath) as! RecipeChoosenTextTableViewCell
                cell.label.text = self.currentFood!.directionDetail[indexPath.section-1][indexPath.row]
                return cell
            }
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierRecipeChoosenTextTableViewCell, for: indexPath) as! RecipeChoosenTextTableViewCell
            cell.label.text = self.currentFood!.ingridientDetail[indexPath.section][indexPath.row]
            return cell
            
        }
        
    }
    
}


//#MARK: - UITableView Delegate
extension RecipeChoosenCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.haveButton {
            switch section {
            case 0:
                return nil
            default:
                return self.currentFood!.directionHeader[section-1]
            }
        } else {
            return self.currentFood!.ingridientHeader[section]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor.white
        view.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.haveButton {
            switch section {
            case 0:
                return 10
            default:
                return 60
            }
        } else {
            return 60
        }
    }
    
}


//#MARK: - UIScrollView Delegate
extension RecipeChoosenCollectionViewCell {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.mainTableView as UIScrollView == scrollView {
            
            if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < scrollView.contentSize.height -  scrollView.frame.size.height {
                if scrollView.contentOffset.y > self.myContentOffsetY {
                    if let animationDelegate = self.animationDelegate {
                        if animationDelegate.getContentOffsetYCombineTopView() > 65 - animationDelegate.getHeightCombineTopView() {
                            animationDelegate.subtractionView(value: (scrollView.contentOffset.y - self.myContentOffsetY)/2)
                            animationDelegate.plusHeightForBotView(value: (scrollView.contentOffset.y - self.myContentOffsetY)/2)
                            animationDelegate.setHeightForDetailCollectionView()
                        } else {
                            animationDelegate.setContentOffsetYToTopForBotView()
                        }
                        self.myContentOffsetY = scrollView.contentOffset.y
                    }
                } else {
                    if let animationDelegate = self.animationDelegate {
                        if animationDelegate.getContentOffsetYCombineTopView() >= 0 {
                            animationDelegate.setContentOffsetYToTopForTopView()
                        } else {
                            animationDelegate.plusContentForView(value: (self.myContentOffsetY - scrollView.contentOffset.y)/2)
                            animationDelegate.plusHeightForBotView(value: (scrollView.contentOffset.y - self.myContentOffsetY)/2)
                            animationDelegate.setHeightForDetailCollectionView()
                        }
                        self.myContentOffsetY = scrollView.contentOffset.y
                    }
                }
            } else {
                if let animationDelegate = self.animationDelegate {
                    animationDelegate.reloadCollectionViewData()
                }
            }
            
        }
    }
    
}









