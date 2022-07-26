//
//  SwiftUIView.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 26/07/2022.
//

import SwiftUI

struct TextView: View {
    var text: String
    @State var lineLimit = 5
    var lineLimitMin = 5
    var body: some View {
        //text as button, acts like a "see more" thing
        Button(
            action: {
                if (lineLimit == lineLimitMin){
                    lineLimit = Int.max
                }
                else {
                    lineLimit = lineLimitMin
                }
            }){
                //text to display
                Text(text)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .lineLimit(lineLimit)
                    .font(.body.bold())
                    .foregroundColor(.white)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: "Dig, Fight, Explore, Build: The very world is at your fingertips as you fight for survival, fortune, and glory. Will you delve deep into cavernous expanses in search of treasure and raw materials with which to craft ever-evolving gear, machinery, and aesthetics? Perhaps you will choose instead to seek out ever-greater foes to test your mettle in combat? Maybe you will decide to construct your own city to house the host of mysterious allies you may encounter along your travels?\n\nIn the World of Terraria, the choice is yours!\n\nBlending elements of classic action games with the freedom of sandbox-style creativity, Terraria is a unique gaming experience where both the journey and the destination are completely in the player’s control. The Terraria adventure is truly as unique as the players themselves!\n\nAre you up for the monumental task of exploring, creating, and defending a world of your own?")
            .background(Color(.black).ignoresSafeArea())
    }
}
