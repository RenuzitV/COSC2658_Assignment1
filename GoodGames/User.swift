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
*/

import Foundation
import SwiftUI

class User: ObservableObject{
    @Published var name = "Duy Nguyen"
    @Published var balance = 100000
    @Published var ownedGames : [Game] = []
    
}
