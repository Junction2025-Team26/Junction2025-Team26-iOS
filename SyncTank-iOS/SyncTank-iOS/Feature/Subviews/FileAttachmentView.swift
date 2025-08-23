//
//  FileAttachmentView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct FileAttachmentView: View {
    let fileBadge: String?
    
    var body: some View {
        HStack(spacing: 12) {
            // 파일 아이콘 (왼쪽)
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.pink)
                    .frame(width: 28, height: 28)
                
                Image(systemName: "doc.text")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
            
            // 파일 정보 (오른쪽)
            VStack(alignment: .leading, spacing: 2) {
                Text("전자책(포폴관련).pdf")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                if let badge = fileBadge {
                    Text(badge)
                        .font(.system(size: 12))
                        .foregroundColor(Color(.systemGray3))
                }
            }
        }
        .padding(16)
        .background(Color(hex: "2C2E33"))
        .cornerRadius(13)
    }
}
