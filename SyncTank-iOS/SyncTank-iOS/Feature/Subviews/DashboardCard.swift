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
                Text(item.title ?? "")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(item.content)
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray3))
                    .lineLimit(3)
            }
            // 첨부 미디어가 있을 경우만 표시
            if let payload = item.attachment {
                HStack {
                    Spacer()
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
                }
            } else {
                // 첨부 없을 경우 대표 썸네일 등
                if item.kind == .plan {
                    HStack {
                        Spacer()
                        PlanThumbnailView()
                    }
                }
            }
        }
        .padding(20)
        .background(Color(hex: "191918"))
        .cornerRadius(16)
    }
}
