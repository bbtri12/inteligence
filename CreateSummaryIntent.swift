CreateSummaryIntent.swift
swift
//
//  CreateSummaryIntent.swift
//  InteligenceDemo
//
//  Created by AI Assistant
//

import AppIntents
import SwiftUI

/// 🎯 Intent dùng để gọi tóm tắt văn bản bằng AI.
/// Siri Shortcut / Widget / Automation có thể dùng intent này để tóm tắt nhanh nội dung.
struct CreateSummaryIntent: AppIntent {
    static var title: LocalizedStringResource = "Tóm tắt văn bản (AI Summary)"
    static var description = IntentDescription("Tạo bản tóm tắt nội dung từ văn bản bằng trí tuệ nhân tạo.")
    
    @Parameter(title: "Nhập văn bản cần tóm tắt")
    var inputText: String
    
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let service = SummaryService()
        var resultText = "Đang xử lý..."
        
        let semaphore = DispatchSemaphore(value: 0)
        
        service.summarizeText(_text: inputText) { summary in
            resultText = summary
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return .result(value: resultText)
    }
}
