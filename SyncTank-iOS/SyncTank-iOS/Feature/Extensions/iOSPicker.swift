//
//  iOSPicker.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

// MARK: - 카메라
struct CameraPicker: UIViewControllerRepresentable {
    var onPicked: (URL, UIImage) -> Void
    var onCancel: () -> Void = {}
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = context.coordinator
        vc.cameraCaptureMode = .photo
        return vc
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker
        init(parent: CameraPicker) { self.parent = parent }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.onCancel()
        }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { parent.onCancel(); return }
            let url = FileManager.default.temporaryDirectory
                .appendingPathComponent("capture_\(UUID().uuidString).jpg")
            if let data = image.jpegData(compressionQuality: 0.9) {
                try? data.write(to: url)
            }
            parent.onPicked(url, image)
        }
    }
}

// MARK: - 앨범(단일 선택)
struct PhotoPicker: UIViewControllerRepresentable {
    var onPicked: (URL, UIImage) -> Void
    var onCancel: () -> Void = {}
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = context.coordinator
        return vc
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }
    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        init(parent: PhotoPicker) { self.parent = parent }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let item = results.first else { parent.onCancel(); return }
            if item.itemProvider.canLoadObject(ofClass: UIImage.self) {
                item.itemProvider.loadObject(ofClass: UIImage.self) { obj, _ in
                    guard let image = obj as? UIImage else { return }
                    let url = FileManager.default.temporaryDirectory
                        .appendingPathComponent("photo_\(UUID().uuidString).jpg")
                    if let data = image.jpegData(compressionQuality: 0.9) {
                        try? data.write(to: url)
                    }
                    DispatchQueue.main.async { self.parent.onPicked(url, image) }
                }
            } else {
                parent.onCancel()
            }
        }
    }
}

// MARK: - 파일(단일 선택)
struct DocumentPicker: UIViewControllerRepresentable {
    var contentTypes: [UTType] = [.data, .image, .pdf, .text]
    var onPicked: (URL) -> Void
    var onCancel: () -> Void = {}
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let vc = UIDocumentPickerViewController(forOpeningContentTypes: contentTypes, asCopy: true)
        vc.allowsMultipleSelection = false
        vc.delegate = context.coordinator
        return vc
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }
    final class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker
        init(parent: DocumentPicker) { self.parent = parent }
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.onCancel()
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { parent.onCancel(); return }
            parent.onPicked(url)
        }
    }
}
