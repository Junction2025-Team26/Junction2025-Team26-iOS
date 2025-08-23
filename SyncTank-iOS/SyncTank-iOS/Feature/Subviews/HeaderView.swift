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
            Text("SyncTank")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            // 탭바
            HStack(spacing: 0) {
                ForEach(InsightViewModel.Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        viewModel.categoryOnChangeTab(tab)
                    }) {
                        VStack(spacing: 8) {
                            Text(tab.rawValue)
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(viewModel.selected == tab ? .white : Color(.systemGray3))
                            
                            // 선택된 탭 표시선
                            Rectangle()
                                .fill(viewModel.selected == tab ? Color.white : Color.clear)
                                .frame(width: 82, height: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 20)
    }
}
