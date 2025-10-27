ActivityView.swift
swift
//
//  ActivityView.swift
//  InteligenceDemo
//
//  Created by AI Assistant
//

import SwiftUI
import UIKit

/// 🧭 Giao diện chia sẻ nội dung (Share Sheet)
/// Cho phép người dùng chia sẻ kết quả tóm tắt, hình ảnh, v.v.
struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Không cần cập nhật gì thêm
    }
}
