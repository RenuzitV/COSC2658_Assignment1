//
//  Game.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 26/07/2022.
//

import Foundation
import SwiftUI

struct Game{
    var name: String
    var description: String
    var shortDescription: String
    var developer: String
    var releaseDate: String
    var reviews: String
    var price: Int
    var genres: String
    var thumbnailName: String {
        name+"_header"
    }
    var imagePaths: [String]{
        var res: [String] = []
        let paths = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: "Terraria")
        for path in paths{
            print(path)
            res.append(path)
        }
        return res
    }
}

