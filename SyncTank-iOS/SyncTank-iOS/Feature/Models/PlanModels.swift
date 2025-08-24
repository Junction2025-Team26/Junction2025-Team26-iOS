//
//  PlanModels.swift
//  SyncTank
//
//  Created by Demian Yoo on 8/23/25.
//

import Foundation

enum ItemKind: String, Codable {
    case plan = "plan"
    case insight = "insight"
}

// 서버/로컬 어디서 오든 썸네일 소스 3종 지원
enum ImageSource: Hashable, Codable {
    case url(String)
    case base64(String)
    case localPath(String)
    
    enum CodingKeys: String, CodingKey {
        case type, value
    }
    
    enum SourceType: String, Codable {
        case url, base64, localPath
    }
    
    // 디코딩
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(SourceType.self, forKey: .type)
        let value = try container.decode(String.self, forKey: .value)
        
        switch type {
        case .url: self = .url(value)
        case .base64: self = .base64(value)
        case .localPath: self = .localPath(value)
        }
    }
    
    // 인코딩
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .url(let val):
            try container.encode(SourceType.url, forKey: .type)
            try container.encode(val, forKey: .value)
        case .base64(let val):
            try container.encode(SourceType.base64, forKey: .type)
            try container.encode(val, forKey: .value)
        case .localPath(let val):
            try container.encode(SourceType.localPath, forKey: .type)
            try container.encode(val, forKey: .value)
        }
    }
}

struct AttachmentPayload: Hashable, Codable {
    let isImage: Bool?         // true면 이미지 썸네일, false면 파일 배지
    let fileExt: String?      // "PDF" 등 (isImage=false 일 때 주로 사용)
    let preview: ImageSource? // isImage=true면 거의 필수
    let fileURLString: String?// 파일 원본 URL/경로 (옵션)
    
    enum CodingKeys: String, CodingKey {
        case isImage = "is_image"
        case fileExt = "file_ext"
        case preview
        case fileURLString = "file_url_string"
    }
}


struct DashItem: Identifiable, Codable, Hashable {
    
    let id: UUID
    let kind: ItemKind?
    let title: String?
    let content: String
    let leftTime: String?
    let attachment: AttachmentPayload?
    let isUpdated: Bool
    
    init(id: UUID = .init(),
         kind: ItemKind,
         title: String,
         content: String,
         leftTime: String?,
         attachment: AttachmentPayload? = nil,
         isUpdated: Bool = false
    ) {
        self.id = id
        self.kind = kind
        self.title = title
        self.content = content
        self.leftTime = leftTime
        self.attachment = attachment
        self.isUpdated = isUpdated
    }
}

struct DashItemDTO: Decodable {
    let id: UUID
    let kind: ItemKind?
    let title: String?
    let content: String
    let leftTime: String?
    let attachment: AttachmentPayload?
    let isUpdated: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, kind, title, content, attachment
        case leftTime = "left_time"
        case isUpdated = "is_updated"
    }
    
    func toDomain() -> DashItem {
        return DashItem(id: id,
                        kind: kind ?? .insight,
                        title: title ?? "",
                        content: content,
                        leftTime: leftTime ?? "")
    }
}
