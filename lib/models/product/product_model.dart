/// Model Sản Phẩm (Thuốc/Thực phẩm chức năng)
class ProductModel {
  final String code;
  final String name;
  final String manufacturer;
  final String lotNumber;
  final DateTime expiryDate;
  final String? licenseNumber;
  final String licenseStatus;
  final String lotStatus;
  final List<String>? activeIngredients;

  ProductModel({
    required this.code,
    required this.name,
    required this.manufacturer,
    required this.lotNumber,
    required this.expiryDate,
    this.licenseNumber,
    required this.licenseStatus,
    required this.lotStatus,
    this.activeIngredients,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      code: json['code'] as String,
      name: json['name'] as String,
      manufacturer: json['manufacturer'] as String,
      lotNumber: json['lot_number'] as String,
      expiryDate: DateTime.parse(json['expiry_date'] as String),
      licenseNumber: json['license_number'] as String?,
      licenseStatus: json['license_status'] as String,
      lotStatus: json['lot_status'] as String,
      activeIngredients: json['active_ingredients'] != null
          ? List<String>.from(json['active_ingredients'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'manufacturer': manufacturer,
      'lot_number': lotNumber,
      'expiry_date': expiryDate.toIso8601String(),
      'license_number': licenseNumber,
      'license_status': licenseStatus,
      'lot_status': lotStatus,
      'active_ingredients': activeIngredients,
    };
  }

  bool get isValid {
    return expiryDate.isAfter(DateTime.now()) &&
        licenseStatus == 'active' &&
        lotStatus == 'verified';
  }
}

