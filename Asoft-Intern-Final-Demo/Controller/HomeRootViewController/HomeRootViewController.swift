//
//  HomeRootViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/23/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class HomeRootViewController: UIViewController {

    //#MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tblMenuView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    //#MARK: - Define properties
    let listFoodArray = ["Meat", "Fish", "Garnishes", "Salads", "Soups", "Bakery", "Deserts"]
    var detailFoodArray: [[Food]] = [[]]
    let menuArray = ["Home", "Favorites", "Combine", "Challenge", "Profile", "Community", "Settings"]
    var navigationTitle = "Recipes"
    var checkInit = true
    var notInHome = false
    
    var combineView: CombineView!
    var profileView: UIView!
    var communityView: CommunityView!
    
    //#MARK: - Set up
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
        
        self.initialization()
        
    }
    
    func initialization() {
        
        for i in 0..<self.listFoodArray.count {
            let amount = arc4random_uniform(100)
            self.detailFoodArray.append([])
            for j in 0..<amount {
                let food = Food(id: NSUUID().uuidString, name: AppResourceIdentifiers.kCategoryNameArray[Int(j % 3)], image: AppResourceIdentifiers.kCategoryImageArray[Int(j % 3)], timeToPerform: Int(arc4random_uniform(30)), type: self.listFoodArray[i], cookingType: ["Beef", "Veal"], videoLink: "", favorite: false, ingridientHeader: AppResourceIdentifiers.kRecipeChoosenTextTableViewHeaderArray, ingridientDetail: AppResourceIdentifiers.kRecipeChoosenTextTableViewCellArray, directionHeader: AppResourceIdentifiers.kRecipeChoosenButtonTableViewHeaderArray, directionDetail: AppResourceIdentifiers.kRecipeChoosenButtonTableViewCellArray)
                self.detailFoodArray[i].append(food)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = false
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
        if self.notInHome {
            indexPath = IndexPath(row: 6, section: 0)
        } else {
            if self.tableView.isHidden == false {
                indexPath = IndexPath(row: 0, section: 0)
            } else if self.combineView.isHidden == false {
                indexPath = IndexPath(row: 2, section: 0)
            } else if self.profileView.isHidden == false {
                indexPath = IndexPath(row: 4, section: 0)
            } else if self.communityView.isHidden == false {
                indexPath = IndexPath(row: 5, section: 0)
            }
        }
        switch indexPath.row {
        case 0:
            self.combineView.isHidden = true
            self.tableView.isHidden = false
            self.profileView.isHidden = true
            self.communityView.isHidden = true
            if let searchBarButtonItem = AppDelegate.shared.searchBarButtonItem {
                self.navigationItem.rightBarButtonItem = searchBarButtonItem
            }
            self.navigationItem.title = AppNavigationTitle.kHomeNavigationTitle
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 1:
            break
        case 2:
            self.tableView.isHidden = true
            self.combineView.isHidden = false
            self.profileView.isHidden = true
            self.communityView.isHidden = true
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kCombineNavigationTitle
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 4:
            self.tableView.isHidden = true
            self.combineView.isHidden = true
            self.communityView.isHidden = true
            self.profileView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kProfileNavigationTitle
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 5:
            self.tableView.isHidden = true
            self.combineView.isHidden = true
            self.profileView.isHidden = true
            self.communityView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kCommunityNavigationTitle
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
        self.combineView.frame.origin.x = UIScreen.main.bounds.width + 3
        self.combineView.frame.origin.y = 64
        self.combineView.frame.size.width = UIScreen.main.bounds.width
        self.combineView.frame.size.height = UIScreen.main.bounds.height - 64
        self.combineView.detailCollectionView.translatesAutoresizingMaskIntoConstraints = true
        self.combineView.menuCollectionView.translatesAutoresizingMaskIntoConstraints = true
        self.combineView.footerMenu.translatesAutoresizingMaskIntoConstraints = true
        let heightForDetailCollectionView = UIScreen.main.bounds.height*2/3 - 50
        self.combineView.detailCollectionView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: heightForDetailCollectionView)
        self.combineView.menuCollectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        self.combineView.footerMenu.frame.size.width = self.combineView.menuCollectionView.frame.size.width/2
    }
    
    func defineProfileView() {
        self.profileView = self.loadViewFromNib(nibName: "ProfileView", frame: self.tblMenuView.bounds)
        self.mainView.addSubview(self.profileView)
        self.profileView.isHidden = true
        self.profileView.frame.origin.x = UIScreen.main.bounds.width + 3
        self.profileView.frame.origin.y = 64
        self.profileView.frame.size.width = UIScreen.main.bounds.width
        self.profileView.frame.size.height = UIScreen.main.bounds.height - 64
    }
    
    func defineCommunityView() {
        self.communityView = self.loadViewFromNib(nibName: "CommunityView", frame: self.tblMenuView.bounds) as! CommunityView
        self.mainView.addSubview(self.communityView)
        self.communityView.isHidden = true
        self.communityView.frame.origin.x = UIScreen.main.bounds.width + 3
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
    
    //#MARK: - Touch up in side button bar items
    func didTouchNextButtonBarItem() {
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.frame.origin.x = -self.tblMenuView.bounds.width - 6
        })
        var indexPath = IndexPath(row: 0, section: 0)
        if self.tableView.isHidden == false {
            indexPath = IndexPath(row: 0, section: 0)
        } else if self.combineView.isHidden == false {
            indexPath = IndexPath(row: 2, section: 0)
        } else if self.profileView.isHidden == false {
            indexPath = IndexPath(row: 4, section: 0)
        } else if self.communityView.isHidden == false {
            indexPath = IndexPath(row: 5, section: 0)
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
            self.navigationItem.title = AppNavigationTitle.kHomeNavigationTitle
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
            self.navigationItem.title = AppNavigationTitle.kCombineNavigationTitle
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 4:
            self.tableView.isHidden = true
            self.combineView.isHidden = true
            self.communityView.isHidden = true
            self.profileView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kProfileNavigationTitle
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        case 5:
            self.tableView.isHidden = true
            self.combineView.isHidden = true
            self.profileView.isHidden = true
            self.communityView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.title = AppNavigationTitle.kCommunityNavigationTitle
            if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                self.navigationItem.leftBarButtonItem = leftBarButtonItem
            }
        default:
            break
        }
    }
    
    @IBAction func didTouchMenuButton(_ sender: Any) {
        self.navigationTitle = self.navigationItem.title!
        self.navigationItem.title = AppNavigationTitle.kMenuNavigationTitle
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = AppDelegate.shared.nextBarButtonItem
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.frame.origin.x = 0
        }, completion: {(_) in
            
        })
    }
    
    @IBAction func didTouchRightBarButtonItem(_ sender: Any) {
        self.performSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueHomeToSearchVC, sender: nil)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierHomeTableViewCell, for: indexPath) as! RecipeMenuTableViewCell
            
            cell.nameLabel.text = listFoodArray[indexPath.row]
            cell.nameLabel.font = UIFont.systemFont(ofSize: cell.bounds.height/2 + 10)
            cell.numberLabel.text = "\(self.detailFoodArray[indexPath.row].count)"
            cell.numberLabel.font = UIFont.systemFont(ofSize: cell.bounds.height/4)
            
            return cell
        case self.tblMenuView:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierMenuTableViewCell, for: indexPath) as! HomeMenuTableViewCell
            
            cell.nameLabel.text = self.menuArray[indexPath.row]
            cell.nameLabel.font = UIFont.systemFont(ofSize: cell.bounds.height/2 + 10)
            
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
            let cell = tableView.cellForRow(at: indexPath) as? RecipeMenuTableViewCell
            let tag2Color = cell?.numberLabel.textColor
            cell?.nameLabel.textColor = UIColor.darkGray
            cell?.numberLabel.textColor = UIColor.darkGray
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
                if let color = AppDelegate.shared.mainColor {
                    cell?.nameLabel.textColor = color
                }
                cell?.numberLabel.textColor = tag2Color
            })
            tableView.deselectRow(at: indexPath, animated: true)
            
            AppNavigationTitle.kCategoryNavigationTitle = (cell?.nameLabel.text!)!
            self.performSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueHomeToCategoryVC, sender: nil)
            
        case self.tblMenuView:
            
            
            let cell = tableView.cellForRow(at: indexPath) as? HomeMenuTableViewCell
            cell?.nameLabel.textColor = UIColor.darkGray
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
                if let color = AppDelegate.shared.mainColor {
                    cell?.nameLabel.textColor = color
                }
            })
            tableView.deselectRow(at: indexPath, animated: true)
            switch indexPath.row {
            case 0:
                self.combineView.isHidden = true
                self.tableView.isHidden = false
                self.profileView.isHidden = true
                self.communityView.isHidden = true
                self.notInHome = false
                if let searchBarButtonItem = AppDelegate.shared.searchBarButtonItem {
                    self.navigationItem.rightBarButtonItem = searchBarButtonItem
                }
                self.navigationItem.title = AppNavigationTitle.kHomeNavigationTitle
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width - 6
                })
            case 1:
                self.notInHome = true
                self.performSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueHomeToFavoriteVC, sender: nil)
            case 2:
                self.tableView.isHidden = true
                self.combineView.isHidden = false
                self.profileView.isHidden = true
                self.communityView.isHidden = true
                self.notInHome = false
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.title = AppNavigationTitle.kCombineNavigationTitle
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width - 6
                })
            case 3:
                self.notInHome = true
                self.performSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueHomeToChallengeVC, sender: nil)
            case 4:
                self.tableView.isHidden = true
                self.combineView.isHidden = true
                self.communityView.isHidden = true
                self.profileView.isHidden = false
                self.notInHome = false
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.title = AppNavigationTitle.kProfileNavigationTitle
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width - 6
                })
            case 5:
                self.tableView.isHidden = true
                self.combineView.isHidden = true
                self.profileView.isHidden = true
                self.communityView.isHidden = false
                self.notInHome = false
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.title = AppNavigationTitle.kCommunityNavigationTitle
                if let leftBarButtonItem = AppDelegate.shared.menuBarButtonItem {
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.x = -self.tblMenuView.bounds.width - 6
                })
            case 6:
                self.notInHome = true
                self.performSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueHomeToSettingVC, sender: nil)
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











