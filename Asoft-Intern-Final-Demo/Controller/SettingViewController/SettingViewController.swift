//
//  SettingViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/30/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        AppDelegate.shared.homeNavigation.navigationItem.rightBarButtonItem = nil
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kSettingNavigationTitle
        
        self.settingTableView.dataSource = self
        self.settingTableView.delegate = self
        
        self.settingTableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//#MARK: - UITableView DataSource
extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return AppResourceIdentifiers.kSettingOptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0, 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierSettingTableViewCellHaveSwitch, for: indexPath) as! SettingHaveSwitchTableViewCell
            cell.optionTextLabel.text = AppResourceIdentifiers.kSettingOptionArray[indexPath.row]
            cell.switchControl.onTintColor = UIColor.untGreyishBrownSwitch
            cell.switchControl.tintColor = UIColor.untWatermelon
            cell.switchControl.layer.cornerRadius = 16
            cell.switchControl.backgroundColor = UIColor.untWatermelon
            if indexPath.row == 0 {
                cell.switchControl.isOn = true
            } else {
                cell.switchControl.isOn = false
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierSettingTableViewCellBasic, for: indexPath)
            cell.textLabel?.text = AppResourceIdentifiers.kSettingOptionArray[indexPath.row]
            return cell
        }
    }
    
}


//#MARK: - UITableView Delegate
extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0, 1:
            let cell = tableView.cellForRow(at: indexPath) as! SettingHaveSwitchTableViewCell
            cell.switchControl.setOn(!cell.switchControl.isOn, animated: true)
        default:
            break
        }
    }
    
}












