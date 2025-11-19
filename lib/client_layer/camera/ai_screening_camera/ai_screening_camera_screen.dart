import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../backend_services/ai_screening_service/ai_screening_service.dart';
import '../../../../core/theme/app_theme.dart';

/// Camera Sàng lọc AI - Chụp ảnh vùng da hoặc nốt ruồi để phân tích
class AIScreeningCameraScreen extends StatefulWidget {
  const AIScreeningCameraScreen({super.key});

  @override
  State<AIScreeningCameraScreen> createState() => _AIScreeningCameraScreenState();
}

class _AIScreeningCameraScreenState extends State<AIScreeningCameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isProcessing = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      await _controller!.initialize();
      setState(() {
        _isInitialized = true;
      });
    }
  }

  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();
      setState(() {
        _capturedImage = image;
        _isProcessing = true;
      });

      // Gửi ảnh đến AI Screening Service
      final result = await AIScreeningService.analyzeImage(image.path);
      
      if (mounted) {
        _showResult(result);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showResult(Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kết quả Sàng lọc'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nguy cơ: ${result['risk_level'] ?? 'N/A'}'),
            const SizedBox(height: 8),
            Text('Độ tin cậy: ${result['confidence'] ?? 'N/A'}%'),
            const SizedBox(height: 8),
            if (result['recommendation'] != null)
              Text('Khuyến nghị: ${result['recommendation']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _capturedImage = null;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sàng Lọc AI - Camera'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Camera Preview
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CameraPreview(_controller!),
          ),

          // Overlay Instructions
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Chụp ảnh vùng da hoặc nốt ruồi cần kiểm tra',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Capture Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: _isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : FloatingActionButton.large(
                      onPressed: _captureImage,
                      backgroundColor: AppTheme.primaryColor,
                      child: const Icon(Icons.camera, size: 40),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

