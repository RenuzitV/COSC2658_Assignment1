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
 https://stackoverflow.com/questions/58341820/isnt-there-an-easy-way-to-pinch-to-zoom-in-an-image-in-swiftui
 */


import SwiftUI

struct GameView: View {
    var game: Game
    @State var isDisplayingSheetConfirm = false
    @State var isDisplayingSheetNotEnoughBalance = false
    @EnvironmentObject var user : User
    
    var body: some View {
        ScrollView{
            
            //title game name
            Text(game.name)
                .font(Font.system(size: 50))
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20.0)
                .leftAligned()
            
            //header pic
            Image(game.thumbnailName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            //short desc
            Text(game.shortDescription)
                .multilineTextAlignment(.center)
                .padding()
                .font(.body.bold())
            
            // dev & game technical info
            VStack(alignment: .center){
                
                //horizontal long line
                ExDivider(width: 1, color: .white, direction: .horizontal)
                    .padding(.horizontal, 10.0)
                
                //information
                
                //define div as short verticle lines
                let div = ExDivider(width: 1, color: .gray, direction: .vertical)
                    .frame(height: 45)
                
                
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
                        //last SmallText also has padding
                    }
                }
                .padding(.vertical, 2.0)
                
                //another horizontal long line
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
            
            //buy button
            Button(action: {
                if (user.balance >= game.price){
                    isDisplayingSheetConfirm.toggle()
                    user.balance -= game.price
                    user.ownedGames.append(game)
                }
                else {
                    isDisplayingSheetNotEnoughBalance.toggle()
                }
            }){
                Text("Buy Now: " + String(game.price) + "đ")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(10)
                    .background(.blue)
                    .cornerRadius(10)
            }
            
            //checkout page
            .sheet(isPresented: $isDisplayingSheetConfirm){
                VStack{
                    Button(action: {
                        isDisplayingSheetConfirm.toggle()
                    }){
                        Text("Close")
                            .font(.title3)
                            .padding(10)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                    .rightAligned()
                    
                    Spacer()
                    
                    Image(game.thumbnailName)
                        .resizable()
                        .frame(width: 400, height: 200)
                        .cornerRadius(10)
                    
                    Text("Thank you for buying " + game.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                }
            }
            
            //not enough balance to buy
            .sheet(isPresented: $isDisplayingSheetNotEnoughBalance){
                VStack{
                    Button(action: {
                        isDisplayingSheetNotEnoughBalance.toggle()
                    }){
                        Text("Close")
                            .font(.title3)
                            .padding(10)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                    .rightAligned()
                    
                    Spacer()
                    
                    Text("You do not have enough balance to buy " + game.name + "!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("Your balance: " + String(user.balance) + "đ")
                        .font(.title3)
                        .padding()
                    
                    Spacer()
                }
            }
            
            //hack to get VStack have full height
            Spacer()
        }
        .padding(.top) //prevents contents from displaying in notch
        .background(colorConstants.backgroundColor)
        .preferredColorScheme(.dark) //force dark mode
        .foregroundColor(.white)
    }
}


struct GameView_Preview: PreviewProvider {
    static var previews: some View {
        GameView(game: gameList[0])
            .environmentObject(User())
    }
}
