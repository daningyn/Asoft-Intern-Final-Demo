//
//  ChefsViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/29/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class ChefsViewController: UIViewController {

    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.untDarkGreyBackground
        self.navigationController?.navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK: - Button Clicked
    
    @IBAction func didTouchUpInBackButton(_ sender: Any) {
        AppDelegate.shared.homeNavigation.popViewController(animated: true)
    }
    
    @IBAction func didTouchUpPlayGordon(_ sender: Any) {
        self.shouldPerformSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueGordonToChefVideo, sender: nil)
    }
    
    @IBAction func didTouchUpPlayMarco(_ sender: Any) {
        self.shouldPerformSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueMarcoToChefVideo, sender: nil)
    }
    
    @IBAction func didTouchUpPlayWolfgang(_ sender: Any) {
        self.shouldPerformSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueWolfgangToChefVideo, sender: nil)
    }
    
    
    //#MARK: - Segue delegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case AppSegueIdentifiers.kIdentifierSegueGordonToChefVideo:
                (segue.destination as! ChefVideoViewController).currentChefs = 0
            case AppSegueIdentifiers.kIdentifierSegueMarcoToChefVideo:
                (segue.destination as! ChefVideoViewController).currentChefs = 1
            case AppSegueIdentifiers.kIdentifierSegueWolfgangToChefVideo:
                (segue.destination as! ChefVideoViewController).currentChefs = 2
            default:
                break
            }
        }
    }

}
