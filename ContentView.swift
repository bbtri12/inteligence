"CẤU TRÚC THƯ MỤC"
inteligenDemo/                     ← Thư mục chính của app
│
├── ContentView.swift              ← Giao diện chính (song ngữ Anh – Việt)
├── SummaryService.swift           ← Dịch vụ tóm tắt (AI)
├── ImageGenerator.swift           ← Trình tạo ảnh (AI)
├── CreateSummaryIntent.swift      ← Intent giúp Siri/Shortcuts gọi tóm tắt
├── ActivityView.swift             ← Chia sẻ ảnh / nội dung
├── Info.plist                     ← Cấu hình ứng dụng
│
├── Assets.xcassets/               ← Biểu tượng và hình ảnh
│   └── AppIcon.appiconset/
│       └── Contents.json
│
├── README.md                      ← Giới thiệu dự án (song ngữ)
├── .gitignore                     ← Loại trừ file hệ thống, build,...
└── LICENSE (tùy chọn)
ContentView.swift
swift
import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var summary: String = ""
    @State private var generating = false

    @State private var imagePrompt: String = "A cat astronaut on the Moon / Mèo phi hành gia trên Mặt Trăng"
    @State private var generatedImage: Image?
    @State private var lastUIImage: UIImage?
    @State private var showShare = false

    private let summaryService = SummaryService()
    private let imageGen = ImageGenerator()

    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    // MARK: - Image Playground
                    VStack(spacing: 12) {
                        Text("🎨 Image Playground / Trình tạo ảnh")
                            .font(.headline)
                        TextField("Describe image (EN or VI)...", text: $imagePrompt)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)

                        Button("Generate Image / Tạo Ảnh") {
                            Task { await generateImage() }
                        }

                        if let img = generatedImage {
                            img.resizable().scaledToFit()
                                .frame(maxHeight: 300)
                                .cornerRadius(10)
                                .padding()
                                .contextMenu {
                                    Button("Share / Chia sẻ") { showShare = true }
                                }
                        }
                    }
                    .tabItem { Label("Image", systemImage: "photo") }

                    // MARK: - Text Summarizer
                    VStack(spacing: 12) {
                        Text("🧠 Text Summarizer / Tóm tắt văn bản")
                            .font(.headline)
                        TextEditor(text: $inputText)
                            .frame(height: 120)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray))

                        Button(action: { Task { await summarize() } }) {
                            HStack {
                                if generating { ProgressView() }
                                Text("Summarize / Tóm tắt")
                            }
                        }

                        if !summary.isEmpty {
                            ScrollView {
                                Text(summary)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(white: 0.95)))
                                    .padding()
                            }
                        }
                    }
                    .tabItem { Label("Text", systemImage: "text.book.closed") }
                }
            }
            .navigationTitle("Inteligen Demo")
            .sheet(isPresented: $showShare) {
                if let ui = lastUIImage {
                    ActivityView(activityItems: [ui])
                }
            }
        }
    }

    func summarize() async {
        generating = true
        do { summary = try await summaryService.summarize(inputText) }
        catch { summary = "Error / Lỗi: \(error.localizedDescription)" }
        generating = false
    }

    func generateImage() async {
        do {
            let ui = try await imageGen.generateImage(from: imagePrompt)
            lastUIImage = ui
            generatedImage = Image(uiImage: ui)
        } catch {
            summary = "Cannot generate image / Không tạo được ảnh"
        }
    }
}
SummaryService.swift
swift
import Foundation

final class SummaryService {
    func summarize(_ text: String) async throws -> String {
        try await Task.sleep(nanoseconds: 600_000_000)
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "No text to summarize / Không có nội dung để tóm tắt." }

        if let first = trimmed.split(separator: ".").first {
            return "Mock summary / Tóm tắt mẫu: \(first)..."
        }
        return "Mock summary / Tóm tắt mẫu: \(String(trimmed.prefix(100)))..."
    }
}

/*
 // Khi Apple FoundationModels có sẵn:
 import FoundationModels
 final class SummaryService {
     private let session = try! LanguageModelSession()
     func summarize(_ text: String) async throws -> String {
         let prompt = "Summarize this text in Vietnamese / Tóm tắt đoạn này:\n\n\(text)"
         let response = try await session.complete(prompt: prompt)
         return response.outputText
     }
 }
*/
ImageGenerator.swift
swift
import UIKit

final class ImageGenerator {
    func generateImage(from prompt: String) async throws -> UIImage {
        let size = CGSize(width: 1024, height: 768)
        return UIGraphicsImageRenderer(size: size).image { ctx in
            UIColor.systemBlue.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
            let p = NSMutableParagraphStyle(); p.alignment = .center
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 40, weight: .bold),
                .paragraphStyle: p,
                .foregroundColor: UIColor.white
            ]
            ("AI Demo Image\n\(prompt)").draw(in: CGRect(x: 0, y: 300, width: size.width, height: 300), withAttributes: attrs)
        }
    }
}
CreateSummaryIntent.swift
swift
import AppIntents

struct CreateSummaryIntent: AppIntent {
    static var title: LocalizedStringResource = "Create Summary / Tạo tóm tắt"
    @Parameter(title: "Text / Văn bản") var text: String

    func perform() async throws -> some IntentResult {
        let result = try await SummaryService().summarize(text)
        return .result(value: result)
    }
}
GenerableModels.swift
swift
import Foundation

struct QuizItem: Codable {
    var question: String
    var options: [String]
    var answerIndex: Int
}
ActivityView.swift
swift

import SwiftUI
import UIKit

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
Info.plist
xml

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDisplayName</key>
    <string>Inteligen Demo</string>
    <key>UILaunchStoryboardName</key>
    <string>Main</string>
    <key>UIRequiresFullScreen</key>
    <true/>
</dict>
</plist>

README.md
markdown

# Inteligen Demo — EN/VI Version

Demo app SwiftUI showing Apple Intelligence-style features.  
Ứng dụng demo SwiftUI mô phỏng tính năng Apple Intelligence.

## Features / Tính năng
- 🎨 Image Playground (Tạo ảnh mô phỏng)
- 🧠 Text Summarizer (Tóm tắt văn bản)
- 🔄 AppIntent (mẫu Shortcuts/Siri)
- 🪶 Offline Mock + Online Ready

## Author
Created by Đức Trí using ChatGPT (GPT-5)

gitignore
build/
DerivedData/
*.xcworkspace
.DS_Store
