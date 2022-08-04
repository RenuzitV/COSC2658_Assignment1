/*
RMIT University Vietnam
Course: COSC2659 iOS Development
Semester: 2022B
Assessment: Assignment 1
Author: Nguyen Vu Minh Duy
ID: s3878076
Created  date: 26/07/2022.
Last modified: 04/08/2022.
Acknowledgement:
*/

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

