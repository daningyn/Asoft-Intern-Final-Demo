//
//  Chef.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import Foundation

class Chef {
    
    var id: String
    var name: String
    var numberOfLike: Int
    var linkVideo: String
    var comment: [Comment]
    
    init(id: String, name: String, numberOfLike: Int, linkVideo: String, comment: [Comment]) {
        self.id = id
        self.name = name
        self.numberOfLike = numberOfLike
        self.linkVideo = linkVideo
        self.comment = comment
    }
    
}
