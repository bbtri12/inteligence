intelligence/
│
├── ContentView.swift          ← (File 1 bạn đã có)
├── SummaryService.swift       ← (File 2 bạn sắp thêm)
├── ImageGenerator.swift       ← (File 3 kế tiếp)
├── CreateSummaryIntent.swift
├── ActivityView.swift
├── Info.plist
├── README.md
└── .gitignore
SummaryService.swift
swift
import Foundation
import SwiftUI

// 🧠 Dịch vụ tóm tắt văn bản (AI)
class SummaryService {
    
    // API endpoint (có thể thay bằng model của OpenAI hoặc HuggingFace nếu bạn muốn mở rộng sau)
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    private let apiKey = "YOUR_API_KEY" // 🔑 Thay bằng khóa thật nếu có

    // Hàm gọi AI để tóm tắt nội dung
    func summarizeText(_ text: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion("❌ URL không hợp lệ.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        // Nội dung gửi lên AI
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are an assistant that summarizes text in both English and Vietnamese."],
                ["role": "user", "content": "Summarize this text in both English and Vietnamese: \(text)"]
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion("❌ Không thể mã hóa dữ liệu gửi lên API.")
            return
        }

        // Gửi yêu cầu đến API
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("❌ Lỗi mạng: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                completion("❌ Không có dữ liệu phản hồi.")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let summary = message["content"] as? String {
                    completion(summary)
                } else {
                    completion("⚠️ Không đọc được phản hồi từ AI.")
                }
            } catch {
                completion("❌ Lỗi phân tích JSON.")
            }
        }.resume()
    }
}
