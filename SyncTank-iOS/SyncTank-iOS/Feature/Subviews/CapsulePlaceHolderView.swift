//
//  CapsulePlaceHolderView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct CapsulePlaceHolderView: View {
    @Binding var text: String
    @FocusState var textfieldFocus: Bool
    var onSend: (String) -> Void = { _ in }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text("Drop, Ask anything")
                    .foregroundStyle(.placeHolder)
                    .font(.system(size: 16, weight: .light))
            }
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .font(.system(size: 16, weight: .light))
                .foregroundStyle(.primary)
                .submitLabel(.send)
                .onSubmit { onSend(text) }
                .focused($textfieldFocus)
        }
        .padding(.vertical, 14)
    }
}
