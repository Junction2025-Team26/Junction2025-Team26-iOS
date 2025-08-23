//
//  HeaderView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: InsightViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            // 대시보드 제목
            Text("Synctank")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            // 탭바 + 하단 선
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(InsightViewModel.Tab.allCases, id: \.self) { tab in
                        Button(action: {
                            viewModel.categoryOnChangeTab(tab)
                        }) {
                            VStack(spacing: 8) {
                                Text(tab.rawValue)
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(viewModel.selected == tab ? .white : Color(.systemGray3))
                                
                                // 선택된 탭 아래 실선
                                Rectangle()
                                    .fill(viewModel.selected == tab ? Color.white : Color.clear)
                                    .frame(height: 3)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
                // 전체 하단 선 (얇은 회색)
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 20)
    }
}
