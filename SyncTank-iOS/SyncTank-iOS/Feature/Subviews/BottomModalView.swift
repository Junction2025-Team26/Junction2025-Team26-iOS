//
//  BottomModalView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct BottomModalView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 모달 헤더
                HStack {
                    Text("File")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
                
                // 모달 콘텐츠
                VStack(spacing: 20) {
                    // 카메라
                    ModalOptionRow(
                        icon: "camera",
                        title: "Camera",
                    )
                    
                    // 앨범에서 선택
                    ModalOptionRow(
                        icon: "photo",
                        title: "Select from Album",
                        
                    )
                    
                    // 파일에서 선택
                    ModalOptionRow(
                        icon: "folder",
                        title: "Select from File",
                    )

                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color("MainInsightWindow"))
            .navigationBarHidden(true)
        }
    }
}

// 모달 옵션 행
struct ModalOptionRow: View {
    let icon: String
    let title: String
    
    
    
    var body: some View {
        Button(action: {
            // TODO: 각 옵션별 액션 구현
            print("isClicked")
        }) {
            HStack(spacing: 16) {
                // 아이콘
                ZStack {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(.white))
                }
                
                // 텍스트 정보
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // 화살표
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(.white))
            }
        }
        .padding(16)
        .background(Color("MainInsightWindow"))
        .cornerRadius(12)
        
        .buttonStyle(PlainButtonStyle())
        
    }
}
