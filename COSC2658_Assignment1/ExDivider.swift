//
//  ExDivider.swift
//  COSC2658_Assignment1
//
//  Created by Duy Nguyen Vu Minh on 26/07/2022.
//

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
