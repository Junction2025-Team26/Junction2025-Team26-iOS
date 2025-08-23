//
//  ContentListView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct ContentListView: View {
    @ObservedObject var viewModel: InsightViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                if viewModel.isFetching {
                    // 페칭 중일 때는 항상 6개 스켈레톤 표시 (페이지 크기만큼)
                    ForEach(0..<viewModel.pageSize, id: \.self) { _ in
                        SkeletonCard()
                    }
                } else if viewModel.items.isEmpty {
                    // 데이터가 없을 때 빈 상태 표시
                    VStack(spacing: 16) {
                        Image(systemName: "doc.text")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("데이터가 없습니다")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                } else {
                    // 실제 데이터 표시
                    ForEach(viewModel.pageItems) { item in
                        DashboardCard(item: item)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .refreshable {
            await viewModel.fetchAllDocs()
        }
        .onAppear {
            // 뷰가 나타날 때 데이터가 없으면 자동으로 페칭
            if viewModel.items.isEmpty {
                Task {
                    await viewModel.fetchAllDocs()
                }
            }
        }
    }
}
