//
//  ChallengeCustomFlowLayout.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 12/30/16.
//  Copyright © 2016 Danh Nguyen. All rights reserved.
//

import UIKit

class ChallengeCustomFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        self.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.itemSize = CGSize(width: (self.collectionView?.frame.size.height)!*0.6, height: (self.collectionView?.frame.size.height)!*0.6)
        let inset = ((self.collectionView?.bounds.width)! - (self.collectionView?.bounds.height)!*0.6)*0.6
        //        let inset: CGFloat = 20
        self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        let centerX: CGFloat = (self.collectionView?.contentOffset.x)! + (self.collectionView?.frame.size.width)!*0.5
        for attrs in array! {
            let delta = abs(centerX - attrs.center.x)
            let scale = 1 - delta / ((self.collectionView?.frame.size.width)! + self.itemSize.width)
            attrs.transform = CGAffineTransform(scaleX: scale, y: scale)
            //        attrs.transform3D = CATransform3DMakeRotation(scale * M_PI_4, 0, 1, 1);
        }
        return array
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var rect: CGRect = CGRect()
        rect.origin = proposedContentOffset
        rect.size = (self.collectionView?.frame.size)!
        let array = super.layoutAttributesForElements(in: rect)
        let centerX = proposedContentOffset.x + (self.collectionView?.frame.size.width)!*0.5
        var minDetal = MAXFLOAT
        for attrs in array! {
            if abs(minDetal) > abs(Float(attrs.center.x - centerX)) {
                minDetal = Float(attrs.center.x - centerX)
            }
        }
        return CGPoint(x: proposedContentOffset.x + CGFloat(minDetal), y: proposedContentOffset.y)
    }
    
    
}
