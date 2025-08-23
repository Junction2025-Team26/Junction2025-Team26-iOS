//
//  DashItemReqeust.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

import Foundation

struct DashItemRequest: Codable {
    let id: String
    let content: String
    let attachment: AttachmentPayloadRequest?
}

struct AttachmentPayloadRequest: Codable {
    let is_image: Bool
    let file_ext: String
    let preview: PreviewSourceRequest
    let file_url_string: String
}

struct PreviewSourceRequest: Codable {
    let type: String  // "url", "base64", "localPath"
    let value: String
}
