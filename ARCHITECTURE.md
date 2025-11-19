# Kiến trúc Hệ thống - Y Tế Flutter AR & AI

## 📐 Tổng quan Kiến trúc

Hệ thống được thiết kế theo kiến trúc **3 lớp (3-Tier Architecture)** với các nguyên tắc:

- **Tách biệt trách nhiệm (Separation of Concerns)**
- **Microservices Architecture** cho Backend
- **Clean Architecture** cho Client Layer
- **Repository Pattern** cho Data Layer

---

## 🏗️ Cấu trúc 3 Lớp

### I. LỚP TRÌNH KHÁCH (Client Layer) - Flutter App

**Vai trò**: Quản lý giao diện người dùng (UI/UX) và các tương tác trực tiếp với thiết bị.

#### 1.1 UI/UX Components
- **Screens**: Các màn hình chính (Home, Screening, Appointment, Profile, Emergency)
- **Widgets**: Components tái sử dụng (HealthCard, ModuleGrid, etc.)
- **Navigation**: Router và Bottom Navigation Bar

#### 1.2 AR Components
- **First Aid AR**: Hướng dẫn sơ cứu với mô hình 3D ảo
- **Hospital Navigation AR**: Chỉ đường trong bệnh viện với mũi tên ảo
- **Exercise Training AR**: Phủ mô hình xương/khớp để sửa tư thế
- **Nutrition Tracking AR**: Quét món ăn và ước tính dinh dưỡng

#### 1.3 Camera & Scanning
- **AI Screening Camera**: Chụp ảnh để phân tích ung thư da/nốt ruồi
- **Product Scanner**: Quét Barcode/QR Code để xác thực sản phẩm

#### 1.4 Security & Location
- **Biometric Auth**: Xác thực vân tay/Face ID
- **GPS Tracker**: Theo dõi vị trí real-time

---

### II. LỚP BACKEND/DỊCH VỤ (Microservices)

**Vai trò**: Chứa logic nghiệp vụ và các thuật toán AI/Machine Learning.

#### 2.1 AI Screening Service
- **Chức năng**: Phân tích hình ảnh bằng Deep Learning
  - Sàng lọc ung thư da (ABCDE)
  - Phân tích tiếng ho/thở
  - Đánh giá stress/trầm cảm qua giọng nói

#### 2.2 Emergency Coordinator Service
- **Chức năng**: Điều phối khẩn cấp
  - Tự động phân loại tình trạng khẩn cấp
  - Điều động xe cấp cứu
  - Gửi thông báo đến bệnh viện

#### 2.3 Appointment Service
- **Chức năng**: Quản lý lịch hẹn & dự báo
  - Bốc số Online (Quản lý hàng đợi)
  - AI dự báo giờ khám chính xác
  - Cảnh báo lên đường thông minh

#### 2.4 AI Coach Service
- **Chức năng**: Lập kế hoạch cá nhân hóa
  - Kế hoạch ăn uống 7 ngày
  - Lộ trình tập luyện 4 tuần
  - Phân tích ràng buộc (bệnh lý, dị ứng)

#### 2.5 Payment Service
- **Chức năng**: Thanh toán tự động (E-Claim)
  - Tự động trừ BHYT
  - Tự động trừ Bảo hiểm Thương mại
  - Xử lý thanh toán cuối cùng

#### 2.6 Product Verification Service
- **Chức năng**: Truy xuất nguồn gốc & xác thực
  - CV + OCR để trích xuất mã
  - Đối chiếu với CSDL
  - Cảnh báo sản phẩm không hợp lệ

#### 2.7 AI Consultation Service
- **Chức năng**: Tư vấn AI
  - Chatbot Y tế (LLM Y khoa)
  - Hướng dẫn sơ cứu

---

### III. LỚP DỮ LIỆU & TÍCH HỢP (Data & Integration Layer)

**Vai trò**: Lưu trữ an toàn, giám sát real-time, và kết nối với dịch vụ bên ngoài.

#### 3.1 Database
- **EHR Database**: Lưu trữ Hồ sơ Y tế Điện tử (mã hóa)
- **Product Database**: Lưu trữ thông tin sản phẩm đã xác thực

#### 3.2 IoT & Real-time
- **IoT Monitoring Service**: Thu thập chỉ số sinh tồn (HR, SpO₂)
- **AI Phân tích Chuỗi Thời gian**: Phát hiện mô hình bất thường
- **Cảnh báo Pop-up Khẩn cấp**: Kích hoạt khi phát hiện bất thường

#### 3.3 External APIs
- **Insurance API**: Tích hợp BHYT và Bảo hiểm Thương mại
- **Payment API**: Tích hợp Ví điện tử/Ngân hàng
- **Maps API**: Tính toán thời gian đi lại (bao gồm giao thông)

#### 3.4 Big Data
- **Epidemiology Service**: Tạo Bản đồ Dịch Tễ (Heatmap)
  - Hiển thị khu vực có nguy cơ dịch bệnh cao

#### 3.5 QR Generator
- **QR Generator Service**: Tạo mã QR duy nhất có thời hạn
  - Chia sẻ Hồ sơ Y tế An toàn

---

## 🔄 Luồng Dữ liệu

### Luồng Sàng Lọc AI
```
User → Camera → AI Screening Service → Backend API → AI Model → Result → UI
```

### Luồng Cấp Cứu Khẩn Cấp
```
User (SOS) → GPS Tracker → Emergency Service → 
  ├─ EHR Database (Phân loại)
  ├─ Ambulance Dispatch
  ├─ Hospital Notification
  └─ User Notification
```

### Luồng Thanh toán Tự động
```
Appointment → Payment Service → 
  ├─ Insurance API (BHYT)
  ├─ Insurance API (Commercial)
  └─ Payment API (Remaining)
```

---

## 🔐 Bảo mật

1. **Mã hóa dữ liệu**: EHR được mã hóa trong database
2. **Xác thực sinh trắc học**: Bảo vệ truy cập hồ sơ nhạy cảm
3. **QR Code có thời hạn**: Chia sẻ an toàn với expiration
4. **HTTPS**: Tất cả API calls sử dụng HTTPS

---

## 📊 Công nghệ Sử dụng

### Client Layer
- **Flutter 3.0+**: Framework chính
- **Riverpod**: State Management
- **ARCore/ARKit**: AR functionality
- **Camera Plugin**: Chụp ảnh
- **Geolocator**: GPS tracking

### Backend Services
- **HTTP/Dio**: API calls
- **TensorFlow Lite**: AI models (on-device)
- **RESTful APIs**: Microservices communication

### Data Layer
- **SQLite**: Local database
- **MQTT**: IoT real-time communication
- **Google Maps API**: Maps & Navigation
- **External APIs**: Insurance, Payment

---

## 🚀 Triển khai

### Development
```bash
flutter pub get
flutter run
```

### Production
- Backend APIs cần được deploy trên cloud
- Database cần backup và replication
- IoT platform cần MQTT broker
- External APIs cần API keys

---

## 📝 Ghi chú

- Các service có thể được scale độc lập (Microservices)
- AR features cần thiết bị hỗ trợ ARCore/ARKit
- AI models có thể chạy on-device hoặc cloud
- Real-time features cần WebSocket/MQTT connection

