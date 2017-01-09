//
//  SearchViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/2/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    //#MARK: - Outlet
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var txtfldSearch: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblResult: UILabel!
    
    //#MARK: - Define properties
    var didSearch = false
    var foods: [Food] = []
    var results: [Food] = []
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialization()
        
        AppDelegate.shared.homeNavigation.navigationItem.rightBarButtonItem = nil
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kSearchNavigationTitle
        
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        self.listTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.txtfldSearch.delegate = self
        
    }
    
    func initialization() {
        for i in 0..<10 {
            let food = Food(id: NSUUID().uuidString, name: AppResourceIdentifiers.kIdentifierSearchNameArray[Int(i%5)], image: AppResourceIdentifiers.kIdentifierSearchImageArray[Int(i%5)], timeToPerform: AppResourceIdentifiers.kSearchTimeArray[Int(i%5)], type: "Pizza", cookingType: ["Beef", "Veal"], videoLink: "", favorite: false, ingridientHeader: AppResourceIdentifiers.kRecipeChoosenTextTableViewHeaderArray, ingridientDetail: AppResourceIdentifiers.kRecipeChoosenTextTableViewCellArray, directionHeader: AppResourceIdentifiers.kRecipeChoosenButtonTableViewHeaderArray, directionDetail: AppResourceIdentifiers.kRecipeChoosenButtonTableViewCellArray)
            self.foods.append(food)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //#MARK: - UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            self.txtfldSearch.resignFirstResponder()
            self.didSearch = true
            for i in 0..<Int(arc4random_uniform(50)) {
                let food = Food(id: NSUUID().uuidString, name: AppResourceIdentifiers.kIdentifierDidSearchNameArray[Int(i%3)], image: AppResourceIdentifiers.kIdentifierDidSearchImageArray[Int(i%3)], timeToPerform: AppResourceIdentifiers.kDidSearchTimeArray[Int(i%3)], type: "Pizza", cookingType: ["Beef", "Veal"], videoLink: "", favorite: false, ingridientHeader: AppResourceIdentifiers.kRecipeChoosenTextTableViewHeaderArray, ingridientDetail: AppResourceIdentifiers.kRecipeChoosenTextTableViewCellArray, directionHeader: AppResourceIdentifiers.kRecipeChoosenButtonTableViewHeaderArray, directionDetail: AppResourceIdentifiers.kRecipeChoosenButtonTableViewCellArray)
                self.results.append(food)
            }
            if self.topView.frame.origin.y < 0 {
                
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.topView.frame.origin.y = self.topView.frame.origin.y - self.topView.bounds.height/2
                    self.listTableView.frame.origin.y = self.topView.frame.origin.y + self.topView.bounds.height
                    self.listTableView.frame.size.height += self.topView.bounds.height/2
                }
            }
            
            UIView.animate(withDuration: 0.5) {
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
            }
            self.lblResult.text = "\(self.results.count) recipes found"
            self.listTableView.reloadData()
        } else {
            self.txtfldSearch.resignFirstResponder()
            self.didSearch = false
            self.results = []
            UIView.animate(withDuration: 0.5, animations: {
                self.topView.frame.origin.y = 0
                self.listTableView.frame.origin.y = self.topView.bounds.height
                self.listTableView.frame.size.height = self.listTableView.superview!.bounds.height - self.topView.bounds.height
                self.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
            }, completion: {(_) in
                self.lblResult.text = "searches this week"
                self.listTableView.reloadData()
            })
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

}


//#MARK: - UITableView DataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.didSearch {
            return self.results.count
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierSearchTableViewCell, for: indexPath) as! SearchTableViewCell
        
        cell.containerView.clipsToBounds = true
        cell.containerView.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 1
        if self.didSearch {
            cell.detailImageView.image = UIImage(named: self.results[indexPath.row].image)
            cell.nameLabel.text = self.results[indexPath.row].name
            cell.timeLabel.text = "\(self.results[indexPath.row].timeToPerform) min"
        } else {
            cell.detailImageView.image = UIImage(named: self.foods[indexPath.row].image)
            cell.nameLabel.text = self.foods[indexPath.row].name
            cell.timeLabel.text = "\(self.foods[indexPath.row].timeToPerform) min "
        }
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/2.5
    }
    
}












