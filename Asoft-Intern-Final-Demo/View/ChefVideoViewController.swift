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
    
    //#MARK: - Define properties
    lazy var currentChefs = 0
    var menuArray = ["VIDEO", "QUOTES"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.untDarkGreyBackground
        self.navigationTitle.text = AppResourceIdentifiers.kChefVideoChefArray[self.currentChefs]
        
        self.menuCollectionView.delegate = self
        self.menuCollectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTouchUpBackButton(_ sender: Any) {
        AppDelegate.shared.homeNavigation.popViewController(animated: true)
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
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}


//#MARK: - UICollectionView Delegate
extension ChefVideoViewController: UICollectionViewDelegate {
    
    
    
}


//#MARK: - UICollectionView DelegateFlowLayout
extension ChefVideoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.menuCollectionView:
            return CGSize(width: collectionView.bounds.width/2, height: 50)
        default:
            return CGSize(width: collectionView.bounds.width/2, height: 50)
        }
    }
    
}








