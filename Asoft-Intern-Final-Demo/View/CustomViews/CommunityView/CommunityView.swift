//
//  CommunityView.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/28/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class CommunityView: UIView {

    @IBAction func didTouchIconPlay(_ sender: Any) {
        AppDelegate.shared.homeNavigation.viewControllers[0].performSegue(withIdentifier: AppSegueIdentifiers.kIdentifierSegueHomeToChefsVC, sender: nil)
    }
    

}
