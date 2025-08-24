//
//  AttachmentPreview.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

import SwiftUI

struct AttachmentPreview: View {
    let payload: AttachmentPayload
    var body: some View {
        if payload.isImage ?? true {
            ImageThumb(source: payload.preview)
        } else {
            FileBadge(ext: payload.fileExt ?? "FILE")
        }
    }
}

private struct ImageThumb: View {
    let source: ImageSource?
    var body: some View {
        Group {
            switch source {
            case .url(let s):
                if let url = URL(string: s) {
                    AsyncImage(url: url) { img in
                        img.resizable().scaledToFill()
                    } placeholder: { ProgressView() }
                } else { placeholder }
            case .base64(let b64):
                if let data = Data(base64Encoded: b64),
                   let ui = UIImage(data: data) {
                    Image(uiImage: ui).resizable().scaledToFill()
                } else { placeholder }
            case .localPath(let path):
                if let ui = UIImage(contentsOfFile: path) {
                    Image(uiImage: ui).resizable().scaledToFill()
                } else { placeholder }
            case .none:
                placeholder
            }
        }
        .frame(width: 92, height: 64)
        .clipped()
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.08), lineWidth: 1))
    }
    private var placeholder: some View {
        ZStack {
            Color(hex: "2C2E33")
            Image(systemName: "photo").foregroundColor(.white.opacity(0.6))
        }
    }
}

private struct FileBadge: View {
    let ext: String
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.pink)
                    .frame(width: 28, height: 28)
                Image(systemName: "doc.text")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(ext.uppercased())
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                Text("Attached")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray3))
            }
        }
        .padding(16)
        .background(Color(hex: "2C2E33"))
        .cornerRadius(13)
    }
}
