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
    
    let listFoodArray = ["Meat", "Fish", "Garnishes", "Salads", "Soups", "Bakery", "Deserts"]
    let listNumberFoodArray = ["79", "118", "417", "51", "352", "49", "291"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//#MARK: - UITableView DataSource
extension HomeRootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants._IDENTIFIER_HOME_TABLE_VIEW_CELL, for: indexPath)
        
        (cell.viewWithTag(1) as! UILabel).text = listFoodArray[indexPath.row]
        (cell.viewWithTag(1) as! UILabel).font = UIFont.systemFont(ofSize: cell.bounds.height/2 + 10)
        (cell.viewWithTag(2) as! UILabel).text = listNumberFoodArray[indexPath.row]
        (cell.viewWithTag(2) as! UILabel).font = UIFont.systemFont(ofSize: cell.bounds.height/4)
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension HomeRootViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.bounds.height - 64) / 7 - 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let tag1Color = (cell?.viewWithTag(1) as! UILabel).textColor
        let tag2Color = (cell?.viewWithTag(2) as! UILabel).textColor
        (cell?.viewWithTag(1) as! UILabel).textColor = UIColor.brown
        (cell?.viewWithTag(2) as! UILabel).textColor = UIColor.brown
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
            (cell?.viewWithTag(1) as! UILabel).textColor = tag1Color
            (cell?.viewWithTag(2) as! UILabel).textColor = tag2Color
        })
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}















