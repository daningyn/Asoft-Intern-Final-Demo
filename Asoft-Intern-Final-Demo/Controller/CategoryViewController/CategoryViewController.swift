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
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    //#MARK: - Define properties
    var btnBarFilter = UIBarButtonItem()
    var selectedCell = 0
    var isOnFilter = false
    lazy var imagePrepareSegue = ""
    lazy var namePrepareSegue = ""
    
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
        self.menuCollectionView.register(UINib(nibName: "MenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierCombineMenuViewCell)
        
        self.detailCollectionView.dataSource = self
        self.detailCollectionView.delegate = self
        
        self.filterTableView.dataSource = self
        self.filterTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK: - Define function bar button
    func didTouchUpButtonFilter() {
        
        if self.isOnFilter == false {
            self.isOnFilter = true
            UIView.animate(withDuration: 0.3) {
                self.mainView.frame.origin.x -= self.filterTableView.frame.size.width
            }
            self.navigationItem.title = AppNavigationTitle.kCategoryFilterNavigationTitle
        } else {
            self.isOnFilter = false
            UIView.animate(withDuration: 0.3) {
                self.mainView.frame.origin.x = 0
            }
            self.navigationItem.title = AppNavigationTitle.kCategoryNavigationTitle
        }
        
    }
    
    //#MARK: - Action Button
    @IBAction func didTouchUpInsideFilterCheck(_ sender: Any) {
        
    }
    
    //#MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == AppSegueIdentifiers.kIdentifierSegueCategoryToRecipeChoosen {
                let recipeChoosenVC = segue.destination as! RecipeChoosenViewController
                recipeChoosenVC.bannerImage = self.imagePrepareSegue
                recipeChoosenVC.navigationTitle = self.namePrepareSegue
            }
        }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierCombineMenuViewCell, for: indexPath) as! MenuCollectionCell
            
            cell.textLabel.text = AppResourceIdentifiers.kCategoryMenuArray[indexPath.row]
            if indexPath.row == self.selectedCell {
                cell.textLabel.textColor = UIColor.black
            } else {
                cell.textLabel.textColor = UIColor.untCoralPink
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdentifierCategoryDetailCollectionViewCell, for: indexPath) as! CategoryDetailCollectionViewCell
            
            cell.pushDelegate = self
            
            return cell
        }
    }
    
}


//#MARK: - UICollectionView Delegate
extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.menuCollectionView:
            self.selectedCell = indexPath.row
            self.detailCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.menuCollectionView.reloadData()
        default:
            break
        }
    }
    
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


//#MARK: - UITableView DataSource
extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppResourceIdentifiers.kCategoryFilterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierCategoryFilterTableViewCell, for: indexPath)
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0,5:
            (cell.viewWithTag(1) as! UILabel).text = ""
            (cell.viewWithTag(2) as! UIButton).setImage(nil, for: .normal)
        default:
            (cell.viewWithTag(1) as! UILabel).text = AppResourceIdentifiers.kCategoryFilterArray[indexPath.row]
            if AppResourceIdentifiers.kCategoryFilterCheckArray[indexPath.row] {
                (cell.viewWithTag(2) as! UIButton).setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconCheck), for: .normal)
            } else {
                (cell.viewWithTag(2) as! UIButton).setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconNotCheck), for: .normal)
            }
        }
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 12
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppResourceIdentifiers.kCategoryFilterCheckArray[indexPath.row] = !AppResourceIdentifiers.kCategoryFilterCheckArray[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if AppResourceIdentifiers.kCategoryFilterCheckArray[indexPath.row] {
            (cell?.viewWithTag(2) as! UIButton).setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconCheck), for: .normal)
        } else {
            (cell?.viewWithTag(2) as! UIButton).setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconNotCheck), for: .normal)
        }
    }
    
}


//#MARK: - PushViewController Delegate
extension CategoryViewController: PushViewController {
    func pushViewControlerWithIdentifierSegue(identifier: String, imageString: String, name: String) {
        self.imagePrepareSegue = imageString
        self.namePrepareSegue = name
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
}








