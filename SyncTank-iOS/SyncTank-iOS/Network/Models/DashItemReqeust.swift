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
    let isImage: Bool
    let fileExt: String
    let preview: PreviewSourceRequest
    let fileUrlString: String
}

struct PreviewSourceRequest: Codable {
    let type: String  // "url", "base64", "localPath"
    let value: String
}
