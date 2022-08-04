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
 https://www.hackingwithswift.com/books/ios-swiftui/encoding-an-observableobject-class
*/

import Foundation
import SwiftUI

class Game : Identifiable, Codable{
    var id : UUID = UUID()
    var name: String
    var description: String
    var shortDescription: String
    var developer: String
    var releaseDate: String
    var reviews: String
    var price: Int
    var storageCost: Int
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
    private enum CodingKeys: String, CodingKey {
        case name, description, shortDescription, developer, releaseDate, reviews, price, storageCost, score, imageFolderName
    }
}

class GameContainer: ObservableObject{
    @Published var games: [Game] = gameList
}
