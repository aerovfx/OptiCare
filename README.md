# Ứng dụng Y Tế Flutter - AR & AI Healthcare System

Hệ thống ứng dụng y tế di động tích hợp AR (Thực tế Tăng cường) và AI (Trí tuệ Nhân tạo) được xây dựng trên Flutter.

## 📋 Tổng quan Kiến trúc

Hệ thống được phân chia thành **3 lớp kiến trúc chính**:

### I. Lớp Trình Khách (Client Layer) - Flutter App
Quản lý giao diện người dùng (UI/UX) và các tương tác trực tiếp với thiết bị (camera, GPS, sinh trắc học).

### II. Lớp Backend/Dịch vụ (Microservices)
Chứa logic nghiệp vụ và các thuật toán AI/Machine Learning phức tạp, được thiết kế theo kiến trúc Microservices.

### III. Lớp Dữ liệu và Tích hợp (Data & Integration Layer)
Chịu trách nhiệm lưu trữ an toàn, giám sát real-time, và kết nối với các dịch vụ bên ngoài.

## 🏗️ Cấu trúc Dự án

```
yte/
├── lib/
│   ├── main.dart
│   │
│   ├── core/                          # Core utilities
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── errors/
│   │
│   ├── client_layer/                  # LỚP TRÌNH KHÁCH
│   │   ├── ui/                        # Giao diện Người dùng
│   │   │   ├── screens/
│   │   │   │   ├── home/
│   │   │   │   ├── screening/
│   │   │   │   ├── appointment/
│   │   │   │   ├── profile/
│   │   │   │   └── emergency/
│   │   │   ├── widgets/
│   │   │   └── navigation/
│   │   │
│   │   ├── ar/                        # AR Components
│   │   │   ├── first_aid_ar/
│   │   │   ├── hospital_navigation_ar/
│   │   │   ├── exercise_training_ar/
│   │   │   └── nutrition_tracking_ar/
│   │   │
│   │   ├── camera/                      # Camera & Scanning
│   │   │   ├── ai_screening_camera/
│   │   │   ├── product_scanner/
│   │   │   └── barcode_scanner/
│   │   │
│   │   ├── security/                   # Bảo mật
│   │   │   └── biometric_auth/
│   │   │
│   │   └── location/                   # Vị trí
│   │       └── gps_tracker/
│   │
│   ├── backend_services/              # LỚP BACKEND/MICROSERVICES
│   │   ├── ai_screening_service/       # AI Sàng Lọc
│   │   ├── emergency_coordinator/      # Điều phối Khẩn cấp
│   │   ├── appointment_service/        # Lịch hẹn & Dự báo
│   │   ├── ai_coach_service/           # AI Coach & Lập kế hoạch
│   │   ├── payment_service/            # Thanh toán Tự động
│   │   ├── product_verification/       # Truy Xuất Nguồn Gốc
│   │   └── ai_consultation/            # Tư vấn AI
│   │
│   ├── data_layer/                    # LỚP DỮ LIỆU & TÍCH HỢP
│   │   ├── database/                   # Database
│   │   │   ├── ehr_database/
│   │   │   └── product_database/
│   │   │
│   │   ├── iot/                        # IoT & Real-time
│   │   │   └── monitoring/
│   │   │
│   │   ├── external_apis/              # External APIs
│   │   │   ├── insurance_api/
│   │   │   ├── payment_api/
│   │   │   └── maps_api/
│   │   │
│   │   ├── big_data/                   # Big Data
│   │   │   └── epidemiology/
│   │   │
│   │   └── qr_generator/               # QR Generator
│   │
│   └── models/                         # Data Models
│       ├── ehr/
│       ├── appointment/
│       ├── emergency/
│       └── product/
│
├── assets/
│   ├── images/
│   ├── icons/
│   ├── models/                         # 3D Models for AR
│   └── animations/
│
└── test/
```

## 🚀 Tính năng Chính

### Client Layer Features
- ✅ Màn hình chính với Thẻ Sức Khỏe Cá Nhân
- ✅ Nút Cấp Cứu Khẩn Cấp (SOS) 24/7
- ✅ Camera Sàng lọc AI (Ung thư da, nốt ruồi)
- ✅ AR Hướng dẫn Sơ cứu (CPR)
- ✅ AR Chỉ Đường Trong Bệnh Viện
- ✅ AR Huấn luyện Tập luyện
- ✅ AR Theo dõi Dinh dưỡng
- ✅ Quét Barcode/QR Code sản phẩm
- ✅ Xác thực Sinh trắc học
- ✅ Chia sẻ Vị trí Real-time

### Backend Services
- ✅ AI Sàng Lọc (Deep Learning)
- ✅ AI Điều phối Khẩn cấp
- ✅ Quản lý Hàng đợi & Dự báo
- ✅ AI Coach & Lập kế hoạch
- ✅ Thanh toán Tự động (E-Claim)
- ✅ AI Truy Xuất Nguồn Gốc
- ✅ Chatbot Y tế (LLM)

### Data & Integration
- ✅ Cơ sở Dữ liệu EHR (Mã hóa)
- ✅ Cơ sở Dữ liệu Truy Xuất Nguồn Gốc
- ✅ IoT/Giám sát Real-time
- ✅ Tích hợp Bản đồ & GPS
- ✅ Big Data & Dịch Tễ
- ✅ Tích hợp API Bảo hiểm
- ✅ Tạo Mã QR Truy cập

## 🛠️ Công nghệ Sử dụng

- **Framework**: Flutter 3.0+
- **State Management**: Riverpod
- **AR**: ARCore (Android) / ARKit (iOS)
- **AI/ML**: TensorFlow Lite
- **Database**: SQLite (Local), Hive
- **Networking**: Dio, Retrofit
- **Real-time**: MQTT, WebSocket

## 📱 Cài đặt

```bash
# Clone repository
git clone <repository-url>
cd yte

# Install dependencies
flutter pub get

# Run app
flutter run
```

## 📄 License

Copyright © 2024

