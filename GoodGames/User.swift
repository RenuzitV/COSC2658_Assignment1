/*
RMIT University Vietnam
Course: COSC2659 iOS Development
Semester: 2022B
Assessment: Assignment 1
Author: Nguyen Vu Minh Duy
ID: s3878076
Created  date: 03/08/2022.
Last modified: 04/08/2022.
Acknowledgement:
 https://www.hackingwithswift.com/books/ios-swiftui/encoding-an-observableobject-class
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-send-state-updates-manually-using-objectwillchange
*/

import Foundation
import SwiftUI

class User: Codable, ObservableObject {
    var name: String{
        didSet {
            objectWillChange.send()
            save("userData.json", self)
        }
    }
    var balance: Int{
        didSet {
            objectWillChange.send()
            save("userData.json", self)
        }
    }
    var ownedGames: [Game]{
        didSet {
            objectWillChange.send()
            save("userData.json", self)
        }
    }
    
    private enum CodingKeys: CodingKey {
        case name, balance, ownedGames
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(balance, forKey: .balance)
        try container.encode(ownedGames, forKey: .ownedGames)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        balance = try container.decode(Int.self, forKey: .balance)
        ownedGames = try container.decode([Game].self, forKey: .ownedGames)
    }
    
    init() {
        name = userData.name
        balance = userData.balance
        ownedGames = userData.ownedGames
    }
}
