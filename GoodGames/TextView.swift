/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 1
 Author: Nguyen Vu Minh Duy
 ID: s3878076
 Created  date: 26/07/2022.
 Last modified: 04/08/2022.
 Acknowledgement:
 https://www.fivestars.blog/articles/trucated-text/
 https://www.fivestars.blog/articles/swiftui-share-layout-information/
 */

import SwiftUI
struct TextView: View {
    var text: String
    @State var isTruncated: Bool = false
    @State var forceFullText: Bool = false
    @State var lineLimit = 5
    @State var seeMoreText = "see more"
    
    var body: some View {
        //turn the entire text into a button, so users can click anywhere to see more
        Button(action: {
            //turns from truncated to full size
            if isTruncated && !forceFullText {
                forceFullText = true
                lineLimit = Int.max
                seeMoreText = "see less"
            }
            //turns from full size to truncated
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
                //if statement to make sure seeMoreText only appears when there is actual truncating happening
                //short texts or force full texts are not affected, and therefore does nothing
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

//MARK: extension to read size of text
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

//MARK: truntcated text
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

//MARK: preview
struct TextView_Preview: PreviewProvider {
    static var previews: some View {
        TextView(text: testGame.description)
            .background(Color(.black))
    }
}

//MARK: left aligned
struct LeftAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}

//MARK: right aligned
struct RightAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
        }
    }
}

//MARK: center aligned
struct CenterAligned: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

//MARK: small text view
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

//MARK: extension for alignments
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
