//
//  User.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 03/08/2022.
//

import Foundation
import SwiftUI

class User: ObservableObject{
    @Published var name = "Duy Nguyen"
    @Published var balance = 100000
    @Published var ownedGames : [Game] = []
    
}
