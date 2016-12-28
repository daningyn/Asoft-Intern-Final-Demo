//
//  HomeRootViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/23/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class HomeRootViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tblMenuView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    let listFoodArray = ["Meat", "Fish", "Garnishes", "Salads", "Soups", "Bakery", "Deserts"]
    let listNumberFoodArray = ["79", "118", "417", "51", "352", "49", "291"]
    let menuArray = ["Home", "Favorites", "Combine", "Profile", "Community", "Settings"]
    var navigationTitle = "Recipes"
    var checkInit = true
    
    var combineView: CombineView!
    var profileView: UIView!
    var communityView: CommunityView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tblMenuView.dataSource = self
        self.tblMenuView.delegate = self
        
        self.navigationController?.navigationBar.hideBottomHairline()
        AppDelegate.shared.menuBarButtonItem = self.navigationItem.leftBarButtonItem
        AppDelegate.shared.searchBarButtonItem = self.navigationItem.rightBarButtonItem
        AppDelegate.shared.nextBarButtonItem = UIBarButtonItem(image: UIImage(named: AppResourceIdentifiers.kIdentifierIconNext), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.didTouchNextButtonBarItem))
        AppDelegate.shared.nextBarButtonItem?.tintColor = UIColor.black
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.checkInit {
            self.checkInit = false
            self.defineCombineView()
            self.defineProfileView()
            self.defineCommunityView()
        }
        
        var indexPath = IndexPath(row: 0, section: 0)
        if self.tableView.isHidden == false {
            indexPath = IndexPath(row: 0, section: 0)
        } else if self.combineView.isHidden == false {
            indexPath = IndexPath(row: 2, section: 0)
        } else if self.profileView.isHidden == false {
            indexPath = IndexPath(row: 3, section: 0)
        }
        switch indexPath.row {
        case 0:
            self.combineView.isHidden = true
            self.tableView.isHidden = false
            self.profileView.isHidden = true
            if let searchBarButtonItem = AppDelegate.shared.searchBarButtonItem {
                self.navigationItem.rightBarButtonItem = searchBarButtonItem
            }
            self.navigationItem.title = AppNavigationTitle.kHomeNavigation
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 1:
            break
        case 2:
            self.tableView.isHidden = true
            self.combineView.isHidden = false
            self.profileView.isHidden = true
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kCombineNavigation
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 3:
            self.tableView.isHidden = true
            self.combineView.isHidden = true
            self.profileView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kProfileNavigation
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        default:
            break
        }
        
    }
    
    //#MARK: - Define Custom View
    func defineCombineView() {
        self.combineView = self.loadCombineViewFromNib(nibName: "CombineView", frame: self.tblMenuView.bounds)
        self.combineView.menuCollectionView.register(UINib(nibName: "MenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierCombineMenuViewCell)
        self.combineView.detailCollectionView.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierImageCollectionViewCell)
        self.combineView.detailCollectionView.register(UINib(nibName: "NameCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.kIdentifierNameCollectionViewCell)
        self.combineView.menuCollectionView.dataSource = self.combineView
        self.combineView.menuCollectionView.delegate = self.combineView
        self.combineView.detailCollectionView.dataSource = self.combineView
        self.combineView.detailCollectionView.delegate = self.combineView
        self.mainView.addSubview(self.combineView)
        self.combineView.isHidden = true
        self.combineView.frame.origin.x = UIScreen.main.bounds.width
        self.combineView.frame.origin.y = 64
        self.combineView.frame.size.width = UIScreen.main.bounds.width
        self.combineView.frame.size.height = UIScreen.main.bounds.height - 64
        self.combineView.detailCollectionView.translatesAutoresizingMaskIntoConstraints = true
        self.combineView.menuCollectionView.translatesAutoresizingMaskIntoConstraints = true
        self.combineView.footerMenu.translatesAutoresizingMaskIntoConstraints = true
        let heightForDetailCollectionView = UIScreen.main.bounds.height*2/3 - 50
        self.combineView.detailCollectionView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: heightForDetailCollectionView)
    }
    
    func defineProfileView() {
        self.profileView = self.loadViewFromNib(nibName: "ProfileView", frame: self.tblMenuView.bounds)
        self.mainView.addSubview(self.profileView)
        self.profileView.isHidden = true
        self.profileView.frame.origin.x = UIScreen.main.bounds.width
        self.profileView.frame.origin.y = 64
        self.profileView.frame.size.width = UIScreen.main.bounds.width
        self.profileView.frame.size.height = UIScreen.main.bounds.height - 64
    }
    
    func defineCommunityView() {
        self.communityView = self.loadViewFromNib(nibName: "CommunityView", frame: self.tblMenuView.bounds) as! CommunityView
        self.mainView.addSubview(self.communityView)
        self.communityView.isHidden = true
        self.communityView.frame.origin.x = UIScreen.main.bounds.width
        self.communityView.frame.origin.y = 64
        self.communityView.frame.size.width = UIScreen.main.bounds.width
        self.communityView.frame.size.height = UIScreen.main.bounds.height - 64
    }
    
    private func loadCombineViewFromNib(nibName: String, frame: CGRect) -> CombineView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = frame
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view as! CombineView
    }
    
    private func loadViewFromNib(nibName: String, frame: CGRect) -> UIView {
        let nib = UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = frame
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }
    
    func didTouchNextButtonBarItem() {
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.frame.origin.x = -self.tblMenuView.bounds.width
        })
        var indexPath = IndexPath(row: 0, section: 0)
        if self.tableView.isHidden == false {
            indexPath = IndexPath(row: 0, section: 0)
        } else if self.combineView.isHidden == false {
            indexPath = IndexPath(row: 2, section: 0)
        } else if self.profileView.isHidden == false {
            indexPath = IndexPath(row: 3, section: 0)
        } else if self.communityView.isHidden == false {
            indexPath = IndexPath(row: 4, section: 0)
        }
        switch indexPath.row {
        case 0:
            self.combineView.isHidden = true
            self.profileView.isHidden = true
            self.communityView.isHidden = true
            self.tableView.isHidden = false
            if let searchBarButtonItem = AppDelegate.shared.searchBarButtonItem {
                self.navigationItem.rightBarButtonItem = searchBarButtonItem
            }
            self.navigationItem.title = AppNavigationTitle.kHomeNavigation
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 1:
            break
        case 2:
            self.tableView.isHidden = true
            self.profileView.isHidden = true
            self.communityView.isHidden = true
            self.combineView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kCombineNavigation
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 3:
            self.tableView.isHidden = true
            self.combineView.isHidden = true
            self.communityView.isHidden = true
            self.profileView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kProfileNavigation
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 4:
            self.tableView.isHidden = true
            self.combineView.isHidden = true
            self.profileView.isHidden = true
            self.communityView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kCommunityNavigation
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        default:
            break
        }
    }
    
    @IBAction func didTouchMenuButton(_ sender: Any) {
        self.navigationTitle = self.navigationItem.title!
        self.navigationItem.title = AppNavigationTitle.kMenuNavigation
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = AppDelegate.shared.nextBarButtonItem
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.frame.origin.x = 0
        }, completion: {(_) in
            
        })
    }
    
    @IBAction func didTouchRightBarButtonItem(_ sender: Any) {
        
    }

}


//#MARK: - UITableView DataSource
extension HomeRootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tableView:
            return self.listFoodArray.count
        case self.tblMenuView:
            return self.menuArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case self.tableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierHomeTableViewCell, for: indexPath)
            
            (cell.viewWithTag(1) as! UILabel).text = listFoodArray[indexPath.row]
            (cell.viewWithTag(1) as! UILabel).font = UIFont.systemFont(ofSize: cell.bounds.height/2 + 10)
            (cell.viewWithTag(2) as! UILabel).text = listNumberFoodArray[indexPath.row]
            (cell.viewWithTag(2) as! UILabel).font = UIFont.systemFont(ofSize: cell.bounds.height/4)
            
            return cell
        case self.tblMenuView:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierMenuTableViewCell, for: indexPath)
            
            (cell.viewWithTag(1) as! UILabel).text = self.menuArray[indexPath.row]
            (cell.viewWithTag(1) as! UILabel).font = UIFont.systemFont(ofSize: cell.bounds.height/2 + 10)
            
            return cell
        default:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            return cell
        }
        
    }
    
}


//#MARK: - UITableView Delegate
extension HomeRootViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case self.tableView:
            return (tableView.bounds.height - 64) / 6 - 5
        case self.tblMenuView:
            return (tableView.bounds.height - 64) / 8
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.tableView:
            let cell = tableView.cellForRow(at: indexPath)
            let tag2Color = (cell?.viewWithTag(2) as! UILabel).textColor
            (cell?.viewWithTag(1) as! UILabel).textColor = UIColor.darkGray
            (cell?.viewWithTag(2) as! UILabel).textColor = UIColor.darkGray
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
                if let color = AppDelegate.shared.mainColor {
                    (cell?.viewWithTag(1) as! UILabel).textColor = color
                }
                (cell?.viewWithTag(2) as! UILabel).textColor = tag2Color
            })
            tableView.deselectRow(at: indexPath, animated: true)
        case self.tblMenuView:
            let cell = tableView.cellForRow(at: indexPath)
            (cell?.viewWithTag(1) as! UILabel).textColor = UIColor.darkGray
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
                if let color = AppDelegate.shared.mainColor {
                    (cell?.viewWithTag(1) as! UILabel).textColor = color
                }
            })
            tableView.deselectRow(at: indexPath, animated: true)
            switch indexPath.row {
            case 0:
                self.combineView.isHidden = true
                self.tableView.isHidden = false
                self.profileView.isHidden = true
                self.communityView.isHidden = true
                if let searchBarButtonItem = AppDelegate.shared.searchBarButtonItem {
                    self.navigationItem.rightBarButtonItem = searchBarButtonItem
                }
                self.navigationItem.title = AppNavigationTitle.kHomeNavigation
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width
                })
            case 1:
                break
            case 2:
                self.tableView.isHidden = true
                self.combineView.isHidden = false
                self.profileView.isHidden = true
                self.communityView.isHidden = true
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.title = AppNavigationTitle.kCombineNavigation
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width
                })
            case 3:
                self.tableView.isHidden = true
                self.combineView.isHidden = true
                self.communityView.isHidden = true
                self.profileView.isHidden = false
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.title = AppNavigationTitle.kProfileNavigation
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width
                })
            case 4:
                self.tableView.isHidden = true
                self.combineView.isHidden = true
                self.profileView.isHidden = true
                self.communityView.isHidden = false
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.title = AppNavigationTitle.kCommunityNavigation
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width
                })
            default:
                break
            }
        default:
            break
        }
        
    }
    
}


//#MARK: - Scroll View Delegate
extension HomeRootViewController {
    

    
}











