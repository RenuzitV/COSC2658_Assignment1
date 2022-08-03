//
//  MainView.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 03/08/2022.
//

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
    }
}	
