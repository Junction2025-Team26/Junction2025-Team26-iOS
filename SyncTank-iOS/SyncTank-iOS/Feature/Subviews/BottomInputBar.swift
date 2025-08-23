//
//  BottomInputBar.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct BottomInputBar: View {
    @Binding var inputText: String
    @State private var showingModal = false
    
    var body: some View {
        HStack(spacing: 16) {
            // 플러스 버튼
            Button(action: {
                showingModal = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color(hex: "43474F"))
                    .clipShape(Circle())
            }
            
            // 입력 필드
            CapsuleInputView(text: $inputText) { value in
                print("Send:", value)
                // TODO: UpStage API 호출
            }
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $showingModal) {
            BottomModalView()
                .presentationDetents([.height(320)])
                .presentationDragIndicator(.visible)
        }
    }
}
