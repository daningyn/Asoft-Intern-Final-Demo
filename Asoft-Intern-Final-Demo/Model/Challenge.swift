//
//  Challenge.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import Foundation

class Challenge {
    
    var id: String
    var name: String
    var imageLink: String
    var requires: [String]
    
    init(id: String, name: Stirng, imageLink: String, requires: [String]) {
        self.id = id
        self.name = name
        self.imageLink = imageLink
        self.requires = requires
    }
    
}
