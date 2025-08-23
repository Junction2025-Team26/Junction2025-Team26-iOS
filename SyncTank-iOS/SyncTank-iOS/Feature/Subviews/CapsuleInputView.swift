//
//  CapsuleInputView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct CapsuleInputView: View {
    @Binding var text: String
    var onSend: (String) -> Void = { _ in }
    
    var body: some View {
        HStack(spacing: 12) {
            
            CapsulePlaceHolderView(text: $text, onSend: onSend)
                .padding(.leading, 20)
            
            Button {
                onSend(text)
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 14)
        }
        .frame(width: 315, height: 46)
        .background(
            RoundedRectangle(cornerRadius: 41, style: .continuous)
                .fill(Color(hex:"43474F"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 41, style: .continuous)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
        .shadow(radius: 8, y: 4)
    }
}
