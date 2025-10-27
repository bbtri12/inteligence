ImageGenerator.swift
swift
//
//  ImageGenerator.swift
//  InteligenceDemo
//
//  Created by AI Assistant
//

import Foundation
import SwiftUI

/// 🧠 Trình tạo ảnh bằng AI (AI Image Generator)
/// AI Image generator service using OpenAI API.
class ImageGenerator {
    
    // 🔑 Thay bằng API key của bạn (hoặc để trống khi chạy demo)
    private let endpoint = "https://api.openai.com/v1/images/generations"
    private let apiKey = "YOUR_API_KEY" // 📝 Thay bằng khóa thật của bạn
    
    /// 🖼️ Hàm gọi API tạo ảnh từ mô tả văn bản
    /// Generate image from text description (English or Vietnamese)
    func generateImage(from prompt: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: endpoint) else {
            print("❌ URL không hợp lệ / Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "model": "gpt-image-1",
            "prompt": prompt,
            "size": "512x512"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("❌ Không thể mã hoá dữ liệu / Failed to encode body:", error)
            completion(nil)
            return
        }
        
        // 📡 Gửi yêu cầu API
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("⚠️ Lỗi mạng / Network error:", error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("❌ Không có dữ liệu trả về / No data received")
                completion(nil)
                return
            }
            
            // 🔍 Giải mã phản hồi JSON
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let dataArr = json["data"] as? [[String: Any]],
                   let first = dataArr.first,
                   let b64 = first["b64_json"] as? String,
                   let imageData = Data(base64Encoded: b64),
                   let image = UIImage(data: imageData) {
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    print("⚠️ Không thể đọc dữ liệu hình ảnh / Invalid image data")
                    completion(nil)
                }
            } catch {
                print("❌ Lỗi giải mã phản hồi / Failed to parse response:", error)
                completion(nil)
            }
        }.resume()
    }
}
