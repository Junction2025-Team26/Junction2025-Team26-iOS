//
//  DashboardCard.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct DashboardCard: View {
    let item: DashItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 제목과 부제목
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(item.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray3))
                    .lineLimit(3)
            }
            
            // 우측 콘텐츠 (썸네일, 파일 등)
            HStack {
                Spacer()
                
                switch item.kind {
                case .plan:
                    PlanThumbnailView()
                case .file, .photo:
                    FileAttachmentView(fileBadge: item.fileBadge)
                }
            }
        }
        .padding(20)
        .background(Color(hex: "191918"))
        .cornerRadius(16)
    }
}
