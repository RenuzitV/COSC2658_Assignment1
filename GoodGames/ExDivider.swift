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
 https://stackoverflow.com/questions/58787180/how-to-change-width-of-divider-in-swiftui
 */

import Foundation
import SwiftUI

struct ExDivider: View {
    var width: CGFloat = 2
    var color: Color = .white
    var direction: Axis.Set = .horizontal
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .applyIf(direction == .vertical) {
                    $0.frame(width: width)
                        .edgesIgnoringSafeArea(.vertical)
                } else: {
                    $0.frame(height: width)
                        .edgesIgnoringSafeArea(.horizontal)
                }
        }
    }
}

extension View {
    @ViewBuilder func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T, else: (Self) -> T) -> some View {
        if condition() {
            apply(self)
        } else {
            `else`(self)
        }
    }
}
