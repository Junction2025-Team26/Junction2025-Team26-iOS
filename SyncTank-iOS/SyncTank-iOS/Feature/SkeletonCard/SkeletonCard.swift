//
//  SkaletonCard.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

import SwiftUI

struct SkeletonCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 제목 스켈레톤
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // 첨부파일 영역 스켈레톤
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
            }
        }
        .padding(20)
        .background(Color(hex: "191918"))
        .cornerRadius(16)
        .shimmering()
    }
}
