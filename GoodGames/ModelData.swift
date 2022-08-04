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
 https://designcode.io/swiftui-advanced-handbook-data-from-json
 https://www.hackingwithswift.com/books/ios-swiftui/encoding-an-observableobject-class
 https://developer.apple.com/documentation/foundation/jsonencoder
*/

import Foundation
import SwiftUI

struct colorConstants{
    static var backgroundColor = Color(hex: 0x0f1a30)
    static var backgroundColor3 = Color(hex: 0x132342)
    static var backgroundColor2 = Color(hex: 0x3c537d)
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func save<T: Encodable>(_ filename: String,_ data: T){

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodedData = try encoder.encode(data)
        try encodedData.write(to: file)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

var gameList: [Game] = load("gameData.json")

var userData: User = load("userData.json")

var testGame = gameList[0]
