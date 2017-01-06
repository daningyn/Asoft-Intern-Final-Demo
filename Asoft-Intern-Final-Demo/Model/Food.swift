//
//  Food.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/6/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import Foundation

class Food {
    
    var id: String
    var name: String
    var image: String
    var timeToPerform: Int
    var type: String
    var videoLink: String
    var favorite: Bool
    var ingridientHeader: [String]
    var ingridientDetail: [[String]]
    var directionHeader: [String]
    var directionDetail: [[String]]
    
    init(id: String, name: String, image: String, timeToPerform: Int, type: String, videoLink: String, favorite: Bool, ingridientHeader: [String], ingridientDetail: [[String]], directionHeader: [String], directionDetail: [[String]]) {
        self.id = id
        self.name = name
        self.image = image
        self.timeToPerform = timeToPerform
        self.type = type
        self.videoLink = videoLink
        self.favorite = favorite
        self.ingridientHeader = ingridientHeader
        self.ingridientDetail = ingridientDetail
        self.directionHeader = directionHeader
        self.directionDetail = directionDetail
    }
    
}
