# Hỗ trợ Platform

## 📱 Các Platform Được Hỗ trợ

Ứng dụng hiện tại hỗ trợ các platform sau:

- ✅ **Android** (Mobile)
- ✅ **iOS** (Mobile)
- ✅ **macOS** (Desktop)
- ✅ **Web** (Chrome, Safari, Firefox)

## ⚠️ Giới hạn Tính năng theo Platform

### Mobile (Android/iOS)
- ✅ Tất cả tính năng hoạt động đầy đủ
- ✅ Camera & AR
- ✅ GPS & Location
- ✅ Biometric Authentication
- ✅ Push Notifications

### macOS (Desktop)
- ✅ UI/UX cơ bản
- ✅ Database (SQLite)
- ✅ Networking
- ⚠️ Camera: Cần cấu hình thêm
- ⚠️ GPS: Không có GPS hardware
- ⚠️ AR: Không hỗ trợ
- ⚠️ Biometric: Có thể dùng Touch ID/Face ID

### Web
- ✅ UI/UX cơ bản
- ✅ Networking
- ⚠️ Camera: Cần permission và có thể hạn chế
- ⚠️ GPS: Cần permission
- ❌ AR: Không hỗ trợ
- ❌ Biometric: Không hỗ trợ
- ⚠️ Database: Sử dụng IndexedDB thay vì SQLite

## 🔧 Cách Chạy Ứng dụng

### Trên Web (Chrome)
```bash
flutter run -d chrome
```

### Trên macOS
```bash
flutter run -d macos
```

### Trên Android Emulator
```bash
# Mở Android Studio và tạo emulator
flutter run
```

### Trên iOS Simulator
```bash
# Mở Xcode và tạo simulator
flutter run
```

### Trên Thiết bị Thật
```bash
# Kết nối thiết bị qua USB
flutter devices  # Xem danh sách thiết bị
flutter run -d <device-id>
```

## 📝 Lưu ý

1. **Camera**: Trên web, cần HTTPS để truy cập camera
2. **GPS**: Trên web, cần user permission
3. **AR**: Chỉ hoạt động trên mobile (Android/iOS)
4. **Database**: SQLite không hoạt động trên web, cần dùng IndexedDB

## 🐛 Xử lý Lỗi Platform-Specific

Nếu gặp lỗi khi chạy trên một platform cụ thể:

1. Kiểm tra dependencies trong `pubspec.yaml`
2. Xem logs: `flutter run -v` (verbose mode)
3. Kiểm tra platform-specific code trong `lib/`

## 🚀 Development Workflow

Để phát triển hiệu quả:

1. **Development**: Sử dụng web hoặc macOS để test UI nhanh
2. **Testing**: Test trên mobile để kiểm tra tính năng đầy đủ
3. **Production**: Build cho Android/iOS

