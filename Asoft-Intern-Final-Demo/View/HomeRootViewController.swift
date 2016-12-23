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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tblMenuView.dataSource = self
        self.tblMenuView.delegate = self
        
        self.navigationController?.navigationBar.hideBottomHairline()
        AppDelegate.shared.leftBarButtonItem = self.navigationItem.leftBarButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTouchMenuButton(_ sender: Any) {
        self.navigationItem.title = "Menu"
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.frame.origin.x = 0
        }, completion: {(_) in
            self.navigationItem.leftBarButtonItem = nil
        })
    }
    
    @IBAction func didTouchRightBarButtonItem(_ sender: Any) {
        if let leftBarButton = AppDelegate.shared.leftBarButtonItem {
            self.navigationItem.leftBarButtonItem = leftBarButton
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants._IDENTIFIER_HOME_TABLE_VIEW_CELL, for: indexPath)
            
            (cell.viewWithTag(1) as! UILabel).text = listFoodArray[indexPath.row]
            (cell.viewWithTag(1) as! UILabel).font = UIFont.systemFont(ofSize: cell.bounds.height/2 + 10)
            (cell.viewWithTag(2) as! UILabel).text = listNumberFoodArray[indexPath.row]
            (cell.viewWithTag(2) as! UILabel).font = UIFont.systemFont(ofSize: cell.bounds.height/4)
            
            return cell
        case self.tblMenuView:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants._IDENTIFIER_MENU_TABLE_VIEW_CELL, for: indexPath)
            
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
            return (tableView.bounds.height - 64) / 7 - 5
        case self.tblMenuView:
            return (tableView.bounds.height - 64) / 7
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.tableView:
            let cell = tableView.cellForRow(at: indexPath)
            let tag1Color = (cell?.viewWithTag(1) as! UILabel).textColor
            let tag2Color = (cell?.viewWithTag(2) as! UILabel).textColor
            (cell?.viewWithTag(1) as! UILabel).textColor = UIColor.darkGray
            (cell?.viewWithTag(2) as! UILabel).textColor = UIColor.darkGray
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
                (cell?.viewWithTag(1) as! UILabel).textColor = tag1Color
                (cell?.viewWithTag(2) as! UILabel).textColor = tag2Color
            })
            tableView.deselectRow(at: indexPath, animated: true)
        case self.tblMenuView:
            let cell = tableView.cellForRow(at: indexPath)
            let tag1Color = (cell?.viewWithTag(1) as! UILabel).textColor
            (cell?.viewWithTag(1) as! UILabel).textColor = UIColor.darkGray
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
                (cell?.viewWithTag(1) as! UILabel).textColor = tag1Color
            })
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            break
        }
        
    }
    
}













