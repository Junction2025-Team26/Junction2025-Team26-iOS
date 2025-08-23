//
//  ContentView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = InsightViewModel()
    @State private var inputText = ""
    @State private var pendingAttachment: AttachmentPayload? = nil
    
    
    
    var body: some View {
        ZStack {
            // 전체 배경
            Color("MainInsightWindow")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 1. 헤더 (Header)
                HeaderView(viewModel: viewModel)
                
                // 2. 콘텐츠 목록 (Content List)
                ContentListView(viewModel: viewModel)
            }
            
            // 3. 하단 입력창 (Bottom Input Bar) - ZStack으로 겹쳐서 표시
            VStack {
                Spacer()
                BottomInputBar(inputText: $inputText){ text, attachment in
                    viewModel.addFromComposer(text: text, attachment: attachment)
                }
            }
        }
        .navigationBarHidden(true)
        .hideKeyboardOnTap()
    }
}

#Preview {
    ContentView()
}
