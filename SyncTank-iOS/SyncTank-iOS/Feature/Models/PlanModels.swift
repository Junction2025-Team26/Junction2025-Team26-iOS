//
//  PlanModels.swift
//  SyncTank
//
//  Created by Demian Yoo on 8/23/25.
//

import Foundation

enum ItemKind: String, Codable { case plan, insight, attachment }

// 서버/로컬 어디서 오든 썸네일 소스 3종 지원
enum ImageSource: Hashable, Codable {
    case url(String)          // 원격 썸네일 URL (문자열로 저장)
    case base64(String)       // 썸네일 Base64 문자열
    case localPath(String)    // 로컬 파일 경로 (드롭 직후 미리보기 등)
    
    // Codable 구현은 필요시 추가(지금은 View 전용으로만 사용해도 OK)
}

struct AttachmentPayload: Hashable, Codable {
    let isImage: Bool         // true면 이미지 썸네일, false면 파일 배지
    let fileExt: String?      // "PDF" 등 (isImage=false 일 때 주로 사용)
    let preview: ImageSource? // isImage=true면 거의 필수
    let fileURLString: String?// 파일 원본 URL/경로 (옵션)
}


struct DashItem: Identifiable, Codable, Hashable {
    let id: UUID
    let kind: ItemKind
    let title: String
    let content: String
    let attachment: AttachmentPayload?
    
    init(id: UUID = .init(),
         kind: ItemKind,
         title: String,
         content: String,
         attachment: AttachmentPayload? = nil) {
        self.id = id
        self.kind = kind
        self.title = title
        self.content = content
        self.attachment = attachment
    }
}
