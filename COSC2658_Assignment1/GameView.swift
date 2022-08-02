//
//  ContentView.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 26/07/2022.
//

import SwiftUI

struct GameView: View {
    var game: Game

    var body: some View {
            ScrollView{
                //title game name
                Text(game.name)
                    .font(Font.system(size: 50))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20.0)
                    .leftAligned()
                //header
                Image(game.thumbnailName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                //short desc
                Text(game.shortDescription)
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.body.bold())
                
                    VStack(alignment: .center){
                        //horizontal long line
                        ExDivider(width: 1, color: .white, direction: .horizontal)
                            .padding(.horizontal, 10.0)
                        
                        //information
                        //define div as short verticle lines
                        let div = ExDivider(width: 1, color: .gray, direction: .vertical)
                            .frame(height: 35)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                //first SmallText has padding otherwise it looks weird
                                SmallText(text: "Score\n" + String(game.score) + "/100")
                                    .padding(.leading)
                                div
                                SmallText(text: "Developer\n" + String(game.developer))
                                div
                                if game.storageCost < 1024 {
                                    SmallText(text: "Space\n" + String(game.storageCost) + " MB")
                                }
                                else {
                                    SmallText(text: "Space\n" + String(game.storageCost/1024) + " GB")
                                }
                                div
                                SmallText(text: "User Review\n" + game.reviews)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.vertical, 5.0)
                        
                        ExDivider(width: 1, color: .white, direction: .horizontal)
                            .padding(.horizontal, 10.0)
                    }
                
                //gallery
                Text("Preview")
                    .fontWeight(.bold)
                    .font(Font.system(size: 30))
                    .multilineTextAlignment(.leading)
                    .padding([.top, .leading], 20)
                    .padding(.bottom, -10)
                    .leftAligned()
                    
                ScrollView(.horizontal){
                    HStack(){
                        ForEach(game.imagePaths.indices, id: \.self){ i in
                            Image(uiImage: UIImage(imageLiteralResourceName: game.imagePaths[i]))
                                .resizable()
                                .frame(width: 380, height: 200, alignment: .center)
                                .padding(.trailing, -2)
                                .cornerRadius(10)
                                .pinchToZoom()
                            if (i < game.imagePaths.count-1) {
                                ExDivider(width: 2, color: .gray, direction: .vertical)
                            }
                        }
                    }
                }
                .cornerRadius(10)
                .padding(10)
                
                //long text description
                TextView(text: game.description)
                    .multilineTextAlignment(.leading)
                
                Text("Buy Now: " + String(game.price) + "đ")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(10)
                    .background(.blue)
                    .cornerRadius(10)
                
                //hack to get VStack have full height
                Spacer()
            }
            .padding(.top) //prevents contents from displaying in notch
            .background(colorConstants.backgroundColor)
            .preferredColorScheme(.dark)
            .foregroundColor(.white)
    }
}

struct SmallText: View {
    var text: String
    var body: some View{
        Text(text)
            .fontWeight(.thin)
            .multilineTextAlignment(.center)
            .padding(.vertical, -10.0)
            .fixedSize()
            .font(Font.system(size: 18))
    }
}

struct GameView_Preview: PreviewProvider {
    static var previews: some View {
        GameView(game: testGame)
    }
}
