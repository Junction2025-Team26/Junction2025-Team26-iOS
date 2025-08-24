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
                BottomInputBar(inputText: $inputText) { text, attachment in
                    Task {
                        await viewModel.uploadAndRefresh(text: text, attachment: attachment)
                    }
                }
            }
            
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .blur(radius: 15)
                .opacity(viewModel.isFetching ? 1 : 0)
                .animation(.spring(duration: 1), value: viewModel.isFetching)
        }
        .navigationBarHidden(true)
        .hideKeyboardOnTap(action: {})
        .overlay(
            Group {
                if let text = viewModel.fetchSuccessText {
                    Text(text)
                        .font(.caption)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.bottom, 100)
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    viewModel.fetchSuccessText = nil
                                }
                            }
                        }
                }
            },
            alignment: .bottom
        )
    }
}

#Preview {
    ContentView()
}
