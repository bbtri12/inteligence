README.md
markdown
# 🤖 InteliGen Demo (AI App)

**Song ngữ / Bilingual: English – Tiếng Việt**

---

## 🌟 Giới thiệu / Introduction

Ứng dụng **InteliGen Demo** là một dự án mẫu sử dụng **Apple Intelligence + OpenAI API**  
để tạo **tóm tắt nội dung (Text Summary)** và **tạo ảnh bằng trí tuệ nhân tạo (AI Image Generation)**.

This demo app uses **Apple Intelligence (Swift + SwiftUI)** integrated with **OpenAI API**  
for smart **text summarization** and **AI-powered image generation**.

---

## 🧩 Cấu trúc dự án / Project Structure
inteligence/
│
├── ContentView.swift          # Giao diện chính / Main interface
├── SummaryService.swift       # Dịch vụ tóm tắt / Text summarization service
├── ImageGenerator.swift       # Tạo ảnh AI / Image generator
├── CreateSummaryIntent.swift  # Tích hợp Siri Shortcut / Siri Intent
├── ActivityView.swift         # Chia sẻ nội dung / Share sheet
├── Info.plist                 # Cấu hình app / App configuration
└── README.md                  # Hướng dẫn / Documentation
---

## ⚙️ Cách chạy / How to Run

### 📱 Trên iPhone hoặc iPad:
1. Cài **Swift Playgrounds** từ App Store  
2. Tải dự án này từ GitHub (chọn “Code → Download ZIP”)  
3. Giải nén → Mở file `ContentView.swift`  
4. Nhấn **Run** ▶️ để chạy app – tạo ảnh & tóm tắt nội dung bằng AI!

---

### 💻 Trên Mac (Xcode):
1. Mở **Xcode 15 trở lên (15.0+)**  
2. Clone dự án từ GitHub:
   ```bash
   git clone https://github.com/<tên-người-dùng>/inteligence.git
   👉 Khi chạy thật, thay bằng:
   bash
   git clone https://github.com/bbtri12/inteligence.git
   3.	Mở file .xcodeproj hoặc .swiftpm
	4.	Chọn thiết bị iPhone thật hoặc Simulator → Bấm Run (⌘R)
	5.	App sẽ khởi chạy, hiển thị giao diện chính với 2 chức năng:
	•	🧠 Tóm tắt nội dung
	•	🖼️ Tạo ảnh AI sáng tạo

⸻

🔑 API Key (nếu cần)

Bạn có thể dùng OpenAI API key để tạo ảnh và tóm tắt nội dung thực tế:
	•	Đăng ký tại: https://platform.openai.com
	•	Thay "YOUR_API_KEY" trong SummaryService.swift và ImageGenerator.swift

⸻

🧠 Tính năng chính / Key Features
Tính năng
Mô tả
🧠 AI Summary
Tóm tắt nội dung tiếng Anh & tiếng Việt bằng OpenAI
🖼️ AI Image
Tạo ảnh sáng tạo từ mô tả bằng văn bản
💬 Siri Shortcut
Gọi nhanh bằng lệnh “Tóm tắt nội dung”
📤 Chia sẻ dễ dàng
Gửi ảnh & kết quả qua Tin nhắn, Mail, Ghi chú

🧰 Công cụ hỗ trợ / Tools Used
	•	SwiftUI (UI chính)
	•	Foundation + Combine (Xử lý API)
	•	Apple Intelligence (iOS 18.7.1)
	•	OpenAI API (AI summary & image generation)
	•	SiriKit + Intents (Shortcut thông minh)

👨‍💻 Tác giả / Author

Nguyễn Đức Trí
GitHub: https://github.com/bbtri12
Dự án phát triển cho iOS 18.7.1 trở lên.
© 2025 – All rights reserved.

⸻

📜 Giấy phép / License

This project is licensed under the MIT License.
Bạn có thể sử dụng, chỉnh sửa và phát hành lại tự do.

⸻

🎯 Hình minh họa / Preview

(Tùy chọn — bạn có thể thêm ảnh chụp màn hình giao diện sau này tại đây)
Ví dụ:
![Preview](https://github.com/bbtri12/inteligence/assets/preview-demo.png)
💡 Mẹo: Sau khi commit, repo sẽ hiển thị README chuyên nghiệp ngay trang đầu GitHub.
---

Sau khi bạn **dán & commit xong**, repo sẽ hiển thị:
- Giao diện chuyên nghiệp có emoji, bảng, khối code  
- Hướng dẫn clone và chạy rõ ràng  
- Phù hợp chuẩn “App AI Demo” như các repo Apple hay OpenAI.

---

Bạn có muốn mình **tạo luôn file `LICENSE (MIT)` chuẩn song ngữ Anh–Việt** để repo bạn hiển thị “MIT License” ở đầu trang không?  
→ GitHub sẽ tự gắn huy hiệu “MIT” (biểu tượng xanh rất đẹp).
