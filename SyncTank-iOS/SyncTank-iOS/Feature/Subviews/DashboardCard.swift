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
                
                Text(item.content)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray3))
                    .lineLimit(3)
            }
            
            HStack {
                Spacer()
                switch item.kind {
                case .plan:
                    PlanThumbnailView()
                    
                case .insight, .attachment:
                    if let payload = item.attachment {
                        VStack(alignment: .trailing, spacing: 4) {
                            AttachmentPreview(payload: payload)
                            
                            if let urlString = payload.fileURLString,
                               let fileName = URL(string: urlString)?.lastPathComponent {
                                Text(fileName)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
            }
        }
        // ✅ VStack 전체에 적용되어야 함
        .padding(20)
        .background(Color(hex: "191918"))
        .cornerRadius(16)
    }
}
