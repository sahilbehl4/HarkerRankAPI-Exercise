//
//  News.swift
//  TestProject
//
//  Created by Sahil Behl on 2020-11-23.
//  Copyright © 2020 sahil. All rights reserved.
//

import Foundation

struct News: Decodable {
    var id : Int
    var deleted: Bool?
    var type: String?
    var by : String?
    var time: Int?
    var text: String?
    var dead: Bool?
    var parent: Int?
    var poll: Int?
    var kids: [Int]?
    var url: String?
    var score: Int?
    var title: String?
    var descendants: Int?
}
