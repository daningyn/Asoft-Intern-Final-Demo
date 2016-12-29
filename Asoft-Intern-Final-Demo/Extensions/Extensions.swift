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

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.height <= 1.0 {
            return (view as? UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension UIColor {
    class var untWatermelon: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 58.0 / 255.0, blue: 106.0 / 255.0, alpha: 1.0)
    }
    
    class var untCoralPink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 105.0 / 255.0, alpha: 1.0)
    }
    
    class var untDarkGreyBackground: UIColor {
        return UIColor(red: 28.0 / 255.0, green: 29.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    }
}


extension UIImage
{
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



