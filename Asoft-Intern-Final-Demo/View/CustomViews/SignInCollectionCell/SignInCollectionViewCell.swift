//
//  SignInCollectionViewCell.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/22/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class SignInCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signUpView: UIView!
    
    var ySignInView: CGFloat!
    var ySignUpView: CGFloat!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ySignInView = UIScreen.main.bounds.height/2
        self.ySignUpView = UIScreen.main.bounds.height - UIScreen.main.bounds.height*(1.8/3)
    }
    
    @IBAction func doTouchSignIn(_ sender: Any) {
        AppDelegate.shared.changeRootViewToHomeVC()
    }
    
    @IBAction func doTouchCreateAccount(_ sender: Any) {
        
    }
    
    @IBAction func didTouchChangeToSignUpView(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.signInView.frame.origin.y = UIScreen.main.bounds.height
        }, completion: {(_) in
            UIView.animate(withDuration: 0.2, animations: {
                self.signUpView.frame.origin.y = self.ySignUpView
            })
        })
    }
    
    @IBAction func didTouchChangeToSignInView(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.signUpView.frame.origin.y = UIScreen.main.bounds.height
        }, completion: {(_) in
            UIView.animate(withDuration: 0.2, animations: {
                self.signInView.frame.origin.y = self.ySignInView
            })
        })
    }
    

}
