//
//  PersonalView.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 03/08/2022.
// reference: https://stackoverflow.com/questions/56726663/how-to-add-a-textfield-to-alert-in-swiftui

import SwiftUI

struct PersonalView: View {
    var background = colorConstants.backgroundColor
    @EnvironmentObject var user : User
    @State private var searchText = ""
    @State private var tempString : String = ""
    @State private var isEditingUsername = false
    
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(colorConstants.backgroundColor)
        UINavigationBar.appearance().barTintColor = UIColor(colorConstants.backgroundColor)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UITabBar.appearance().barTintColor = UIColor(colorConstants.backgroundColor)
        //        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(.white), .font: UIFont.systemFont(ofSize: 20)]
    }
    
    var body: some View {
        VStack{
            HStack{
                if (!isEditingUsername){
                    HStack{
                        Text("Hi, " + user.name)
                            .font(.title)
                    
                        Spacer()
                        
                        Button(action:{
                            isEditingUsername.toggle()
                            tempString = user.name
                        }){
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(0)
                } else {
                    HStack{
                        TextField("change username", text: $tempString)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.words)
                            .padding(.leading, 5)
                            .font(.title)
                            .background(colorConstants.backgroundColor3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.green, lineWidth: 2)
                                    .opacity(0.7)
                            )
                        
                        Spacer()
                        
                        //cancel
                        Button(action:{
                            isEditingUsername.toggle()
                        }){
                            Image(systemName: "x.circle")
                                .foregroundColor(.blue)
                        }
                        
                        //confirm
                        Button(action:{
                            user.name = tempString
                            isEditingUsername.toggle()
                        }){
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(20)
            
            HStack{
                Text("Balance: " + String(user.balance))
                    .font(.title3)
                
                Button(action:{
                    user.balance += Int(1e5)
                }){
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                }
            }
            .leftAligned()
            .padding(20)
            
            NavigationView{
                List(user.ownedGames){ game in
                    HStack{
                        GameRow(game: game)
                        Spacer()
                    }
                    .padding(.leading, -15)
                    .padding(.trailing, -25)
                    .listRowBackground(colorConstants.backgroundColor)
                    .listRowSeparatorTint(.gray)
                }
                .searchable(text: $searchText)
                .foregroundColor(.white)
                .listStyle(.grouped)
                .navigationTitle("Owned Games")
                .foregroundColor(.white)
            }
        }
        .background(background)
        .foregroundColor(.white)
    }
    
    var searchResults: [Game] {
        if searchText.isEmpty {
            return user.ownedGames
        } else {
            return user.ownedGames.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
}
