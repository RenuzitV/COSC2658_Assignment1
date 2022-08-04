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
import SwiftUI


@main
struct COSC2658_Assignment1App: App {
    var body: some Scene {
        //parse 1 environment object, which is user
        //this will be changed to also have games, but it is loaded via swift for the moment
        WindowGroup {
            MainView()
                .environmentObject(User())
        }
    }
}

