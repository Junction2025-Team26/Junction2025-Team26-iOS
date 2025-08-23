//
//  AttachmentPayload.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

import Foundation

func makeBase64PreviewPayload(from url: URL) -> AttachmentPayload? {
    guard let data = try? Data(contentsOf: url) else {
        print("❌ 파일 데이터를 불러올 수 없습니다.")
        return nil
    }

    let base64String = data.base64EncodedString()
    let fileExt = url.pathExtension.uppercased()
    let isImage = ["JPG", "JPEG", "PNG", "HEIC", "GIF", "WEBP"].contains(fileExt)

    return AttachmentPayload(
        isImage: isImage,
        fileExt: fileExt.isEmpty ? "FILE" : fileExt,
        preview: .base64(base64String),
        fileURLString: "" // 서버에 안 보내도 됨
    )
}
