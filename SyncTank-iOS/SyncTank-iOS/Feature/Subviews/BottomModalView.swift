//
//  BottomModalView.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct BottomModalView: View {
    @Environment(\.dismiss) private var dismiss
    
    var onAttach: (AttachmentPayload) -> Void = { _ in }
    var onToast: (String) -> Void = { _ in }
    var onSelectPicker: (PickerType) -> Void
    
    @State private var activePicker: PickerType? = nil
    
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
                
                // 옵션 리스트
                VStack(spacing: 20) {
                    ModalOptionRow(icon: "camera", title: "Camera") {
                        presentPicker(.camera)
                    }
                    ModalOptionRow(icon: "photo", title: "Select from Album") {
                        presentPicker(.photo)
                    }
                    ModalOptionRow(icon: "folder", title: "Select from File") {
                        presentPicker(.file)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color("MainInsightWindow"))
            .navigationBarHidden(true)
        }
    }
    
    // 딜레이를 포함한 안전한 전환
    private func presentPicker(_ type: PickerType) {
        Task {
            dismiss()
            onSelectPicker(type)
        }
    }
    
    struct ModalOptionRow: View {
        let icon: String
        let title: String
        var action: () -> Void
        var body: some View {
            Button(action: action) {
                HStack(spacing: 16) {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(16)
                .background(Color("MainInsightWindow"))
                .cornerRadius(12)
            }
            .buttonStyle(.plain)
        }
    }
}
