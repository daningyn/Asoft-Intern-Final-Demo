//
//  User.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import Foundation

class User {
    
    var id: String
    var name: String
    var imageLink: String
    var position: [String]
    var numberOfFollowing: Int
    var numberOfFollower: Int
    var numberOfRecipe: Int
    
    init(id: String, name: String, imageLink: String, position: [String], numberOfFollowing: Int, numberOfFollower: Int, numberOfRecipe: Int) {
        self.id = id
        self.name = name
        self.imageLink = imageLink
        self.position = position
        self.numberOfFollowing = numberOfFollowing
        self.numberOfFollower = numberOfFollower
        self.numberOfRecipe = numberOfRecipe
    }
    
}
