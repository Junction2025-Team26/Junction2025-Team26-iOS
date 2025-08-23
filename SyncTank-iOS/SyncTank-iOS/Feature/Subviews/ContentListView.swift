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
                ForEach(viewModel.filtered) { item in
                    DashboardCard(item: item)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
