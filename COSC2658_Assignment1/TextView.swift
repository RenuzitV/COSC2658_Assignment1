//
//  SwiftUIView.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 26/07/2022.
//

import SwiftUI
struct TextView: View {
    var text: String
    @State var isTruncated: Bool = false
    @State var forceFullText: Bool = false
    @State var lineLimit = 5
    @State var seeMoreText = "see more"
    
    var body: some View {
        Button(action: {
        if isTruncated && !forceFullText {
            forceFullText = true
            lineLimit = Int.max
            seeMoreText = "see less"
        }
        else if forceFullText{
            forceFullText = false
            lineLimit = 5
            seeMoreText = "see more"
        }
        }){
            VStack(alignment: .leading) {
                TruncableText(
                    text: textElm,
                    lineLimit: lineLimit
                ){
                    isTruncated = $0
                }
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .font(.body.bold())
                    .foregroundColor(.white)
                if (isTruncated && !forceFullText ) || (forceFullText) {
                    Text(seeMoreText)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.top, -5)
                }
            }
        }
        .padding(.vertical)
    }
    
    var textElm: Text {
        Text(text)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct TruncableText: View {
    let text: Text
    let lineLimit: Int?
    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero
    let isTruncatedUpdate: (_ isTruncated: Bool) -> Void
    
    var body: some View {
        text
            .lineLimit(lineLimit)
            .readSize { size in
                truncatedSize = size
                isTruncatedUpdate(truncatedSize != intrinsicSize)
            }
            .background(
                text
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .readSize { size in
                        intrinsicSize = size
                        isTruncatedUpdate(truncatedSize != intrinsicSize)
                    }
            )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: games[0].description)
            .background(Color(.black))
    }
}

struct LeftAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}

struct RightAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
        }
    }
}

struct CenterAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}



extension View {
    func leftAligned() -> some View {
        return self.modifier(LeftAligned())
    }
    func rightAligned() -> some View {
        return self.modifier(RightAligned())
    }
    func centerAligned() -> some View {
        return self.modifier(CenterAligned())
    }
}
