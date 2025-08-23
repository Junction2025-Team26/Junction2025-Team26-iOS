//
//  BottomInputBar.swift
//  SyncTank-iOS
//
//  Created by 차원준 on 8/23/25.
//

import SwiftUI

struct BottomInputBar: View {
    @Binding var inputText: String
    @State private var showingModal = false
    @State private var pendingAttachment: AttachmentPayload? = nil
    
    @State private var activePicker: PickerType? = nil
    
    var onSend: (String, AttachmentPayload?) -> Void = { _, _ in }
    
    var body: some View {
        VStack(spacing: 8) {
            
            if let att = pendingAttachment {
                HStack {
                    Spacer().frame(width: 60)
                    AttachmentPreview(payload: att)
                    Spacer()
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            HStack(spacing: 16) {
                // 플러스 버튼
                Button(action: {
                    showingModal = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color(hex: "43474F"))
                        .clipShape(Circle())
                }
                
                // 입력 필드
                CapsuleInputView(text: $inputText) { value in
                    print("Send: \(value)")
                    
                    let attachmentCopy = pendingAttachment
                    
                    onSend(value, attachmentCopy)
                    
                    // 서버에 전송
                    Task {
                        do {
                            let id = UUID().uuidString
                            let content = value.isEmpty ? "No message" : value
                            let request = DashItemRequest(
                                id: id,
                                content: content,
                                attachment: attachmentCopy?.toRequest()
                            )
                            
                            let result = try await APIService.shared.saveDocs(request)
                            print("✅ 서버 저장 성공: \(result)")
                        } catch {
                            print("❌ 서버 저장 실패: \(error)")
                        }
                    }
                    pendingAttachment = nil
                    // TODO: UpStage API 호출
                }
            }
            
            // ✅ 2. 키보드와 살짝 띄우기
            Spacer().frame(height: 8)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8) // 키보드와 바닥 여백
        .sheet(isPresented: $showingModal) {
            BottomModalView(
                onAttach: { payload in
                    pendingAttachment = payload
                },
                onToast: { toast in
                    // 토스트 처리
                },
                onSelectPicker: { picker in
                    // 1. 먼저 모달 닫기
                    showingModal = false
                    
                    // 2. 모달이 내려간 뒤 picker 띄우기
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        activePicker = picker
                    }
                }
            )
            .presentationDetents([.height(320)])
            .presentationDragIndicator(.visible)
            .hideKeyboardOnTap()
        }
        .sheet(item: $activePicker) { picker in
            switch picker {
            case .camera:
                CameraPicker { url, _ in
                    pendingAttachment = makeBase64PreviewPayload(from: url)
                    activePicker = nil
                } onCancel: {
                    activePicker = nil
                }
                
            case .photo:
                PhotoPicker { url, _ in
                    pendingAttachment = makeBase64PreviewPayload(from: url)
                    activePicker = nil
                } onCancel: {
                    activePicker = nil
                }
                
            case .file:
                DocumentPicker { url in
                    pendingAttachment = makeBase64PreviewPayload(from: url)
                    activePicker = nil
                } onCancel: {
                    activePicker = nil
                }
            }
        }
    }
}

extension AttachmentPayload {
    func toRequest() -> AttachmentPayloadRequest? {
        guard let preview = preview else { return nil }
        
        let previewRequest: PreviewSourceRequest
        switch preview {
        case .url(let value):
            previewRequest = PreviewSourceRequest(type: "url", value: value)
        case .base64(let value):
            previewRequest = PreviewSourceRequest(type: "base64", value: value)
        case .localPath(let value):
            previewRequest = PreviewSourceRequest(type: "localPath", value: value)
        }
        
        return AttachmentPayloadRequest(
            is_image: isImage,
            file_ext: fileExt ?? "FILE",
            preview: previewRequest,
            file_url_string: fileURLString ?? ""
        )
    }
}
