//
//  Comment.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import Foundation


class Comment {
    
    var id: String
    var idChef: String
    var comment: String
    var feels: [String]
    var numberOfLike: String
    
    init(id: String, idChef: String, comment: String, feels: [String], numberOfLike: String) {
        self.id = id
        self.idChef = idChef
        self.comment = comment
        self.feels = feels
        self.numberOfLike = numberOfLike
    }
    
}
