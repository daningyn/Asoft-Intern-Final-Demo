//
//  Extensions.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/23/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(netHex:Int) {
        self.init(colorLiteralRed:Float((netHex >> 16) & 0xff), green:Float((netHex >> 8) & 0xff), blue:Float(netHex & 0xff), alpha: 100)
    }
    
}
