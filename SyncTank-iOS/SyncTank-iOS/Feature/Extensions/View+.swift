//
//  View+.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//
import SwiftUI

extension View {
    func hideKeyboardOnTap(action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            action()
        }
    }
    
    func shimmering() -> some View {
        self
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .white.opacity(0.4), .clear]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .rotationEffect(.degrees(30))
                .offset(x: -200)
                .animation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false),
                    value: UUID()
                )
            )
            .mask(self)
    }
}
