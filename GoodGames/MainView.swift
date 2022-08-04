/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 1
 Author: Nguyen Vu Minh Duy
 ID: s3878076
 Created  date: 28/07/2022.
 Last modified: 04/08/2022.
 Acknowledgement:
 https://peterfriese.dev/posts/swiftui-listview-part3/
 https://developer.apple.com/documentation/swiftui/tabview
 */

import SwiftUI

struct MainView: View {
    init(){
        UITableView.appearance().backgroundColor = UIColor(colorConstants.backgroundColor)
        UINavigationBar.appearance().barTintColor = UIColor(colorConstants.backgroundColor)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UITabBar.appearance().barTintColor = UIColor(colorConstants.backgroundColor)
    }
    
    var body: some View {
        TabView {
            GameList(gameList: gamesList)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Games")
                }
            PersonalView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Personal")
                }
        }
        .font(.headline)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(User())
    }
}	
