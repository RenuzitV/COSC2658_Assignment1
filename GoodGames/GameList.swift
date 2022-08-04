/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 1
 Author: Nguyen Vu Minh Duy
 ID: s3878076
 Created  date: 02/08/2022.
 Last modified: 04/08/2022.
 Acknowledgement:
 https://peterfriese.dev/posts/swiftui-listview-part3/
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-a-search-bar-to-filter-your-data
 */

import SwiftUI

struct GameList: View {
    var games: [Game]
    var background = UIColor(colorConstants.backgroundColor)
    @State private var searchText = ""
    
    //setup colors for view
    init(gameList: [Game]) {
        self.games = gamesList
        UITableView.appearance().backgroundColor = background
        UINavigationBar.appearance().barTintColor = background
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UITabBar.appearance().barTintColor = background
    }
    
    var body: some View {
        NavigationView{
            //make a list of games that match the search bar query
            List(searchResults){ game in
                HStack{
                    GameRow(game: game)
                    Spacer()
                }
                //puts a NavLink in the background to redirect users towards the detailed view of that game
                .background(
                    NavigationLink(destination: GameView(game: game)){}
                        .opacity(0)
                )
                .padding(.leading, -15)
                .padding(.trailing, -25)
                .listRowBackground(colorConstants.backgroundColor)
                .listRowSeparatorTint(.gray)
            }
            //append search bar
            .searchable(text: $searchText)
            .foregroundColor(.white)
            .listStyle(.grouped)
            .navigationTitle(
                "GoodGames"
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(.bottom, -10)
    }
    
    //searches for games with matching name, case-insensitive, returns all if not used
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
            .environmentObject(User())
    }
}
