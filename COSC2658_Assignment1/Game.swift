//
//  Game.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 26/07/2022.
//

import Foundation
import SwiftUI

struct Game : Identifiable{
    var id = UUID()
    var name: String
    var description: String
    var shortDescription: String
    var developer: String
    var releaseDate: String
    var reviews: String
    var price: Int
    var genres: String
    var storageCost: Int = 500
    var score: Int
    var imageFolderName : String
    var thumbnailName: String {
        imageFolderName+"_header"
    }
    var imagePaths: [String]{
        var res: [String] = []
        let paths = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: imageFolderName)
        for path in paths{
            res.append(path)
        }
        return res
    }
}

