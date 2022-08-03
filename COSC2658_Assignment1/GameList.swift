//
//  GameList.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 02/08/2022.
//

import SwiftUI

struct GameList: View {
    var games: [Game]
    var background = UIColor(colorConstants.backgroundColor)
    @State private var searchText = ""
    
    init(gameList: [Game]) {
        self.games = gamesList
        UITableView.appearance().backgroundColor = UIColor(colorConstants.backgroundColor)
        UINavigationBar.appearance().barTintColor = UIColor(colorConstants.backgroundColor)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UITabBar.appearance().barTintColor = UIColor(colorConstants.backgroundColor)
    }
    
    var body: some View {
        NavigationView{
            List(searchResults){ game in
                HStack{
                    GameRow(game: game)
                    Spacer()
                }
                .background(
                    NavigationLink(destination: GameView(game: game)){}
                        .opacity(0)
                )
                .padding(.leading, -15)
                .padding(.trailing, -25)
                .listRowBackground(colorConstants.backgroundColor)
                .listRowSeparatorTint(.gray)
            }
            .searchable(text: $searchText)
            .foregroundColor(.white)
            .listStyle(.grouped)
            .navigationTitle(
                "GoodGames"
            )
        }
        .padding(.bottom, -10)
    }
    
    var searchResults: [Game] {
        if searchText.isEmpty {
            return games
        } else {
            return games.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        GameList(gameList: gamesList)
            .previewInterfaceOrientation(.portrait)
    }
}
