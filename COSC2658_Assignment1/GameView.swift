//
//  ContentView.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 26/07/2022.
//

import SwiftUI

struct GameView: View {
    var game: Game
    @State var lineLimit = 5
    
    var body: some View {
            ScrollView{
                VStack(alignment: .leading){
                    Spacer()
                        .frame(height: 10.0)
                    
                    //title game name
                    Text(game.name)
                        .font(Font.system(size: 50))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(.leading, 15.0)
                        
                    //header
                    Image(game.thumbnailName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    //short desc
                    Text(game.shortDescription)
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(.body.bold())
                        .foregroundColor(.white)
                    
                    
                    //gallery
                    ScrollView(.horizontal){
                        HStack(){
                            ForEach(game.imagePaths.indices, id: \.self){ i in
                                Image(uiImage: UIImage(imageLiteralResourceName: game.imagePaths[i]))
                                    .resizable()
                                    .frame(width: 400, height: 200, alignment: .center)
                                    .padding(.trailing, -2)
                                    .cornerRadius(10)
                                if (i < game.imagePaths.count-1) {
                                    ExDivider(width: 2, color: .gray, direction: .vertical)
                                }
                            }
                        }
                    }
                    .cornerRadius(10)
                    .padding(10)
                    
                    List(game.imagePaths, id: \.self) {imagePath in
                            Image(uiImage: UIImage(imageLiteralResourceName: imagePath))
                                .resizable()
                                .frame(width: 400, height: 200, alignment: .center)
                    }
                    
                    
                    
                    TextView(text: game.description)
                        .multilineTextAlignment(.leading)
                        
                    
                    
                    //hack to get VStack have full height
                    Spacer()
                }
            }
            .background(Color(red: 0.092, green: 0.102, blue: 0.128).ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: games[0])
    }
}
