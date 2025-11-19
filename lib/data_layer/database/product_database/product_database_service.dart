import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

/// Cơ sở Dữ liệu Truy Xuất Nguồn Gốc - Thuốc và Thực phẩm chức năng
class ProductDatabaseService {
  static Database? _database;
  static const String _dbName = 'product_database.db';
  static const String _tableName = 'products';

  /// Khởi tạo database
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            product_code TEXT UNIQUE NOT NULL,
            name TEXT NOT NULL,
            manufacturer TEXT NOT NULL,
            lot_number TEXT NOT NULL,
            expiry_date TEXT NOT NULL,
            license_number TEXT,
            license_status TEXT,
            lot_status TEXT,
            active_ingredients TEXT,
            verified_at INTEGER,
            created_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  /// Lấy thông tin sản phẩm
  static Future<Map<String, dynamic>?> getProductInfo(String code) async {
    final db = await database;
    final results = await db.query(
      _tableName,
      where: 'product_code = ? OR lot_number = ?',
      whereArgs: [code, code],
      limit: 1,
    );

    if (results.isEmpty) return null;

    final product = results.first;
    return {
      'code': product['product_code'],
      'name': product['name'],
      'manufacturer': product['manufacturer'],
      'lot_number': product['lot_number'],
      'expiry_date': product['expiry_date'],
      'license_number': product['license_number'],
      'license_status': product['license_status'],
      'lot_status': product['lot_status'],
      'active_ingredients': product['active_ingredients'],
    };
  }

  /// Thêm sản phẩm vào database
  static Future<void> addProduct(Map<String, dynamic> product) async {
    final db = await database;
    await db.insert(
      _tableName,
      {
        'product_code': product['code'],
        'name': product['name'],
        'manufacturer': product['manufacturer'],
        'lot_number': product['lot_number'],
        'expiry_date': product['expiry_date'],
        'license_number': product['license_number'],
        'license_status': product['license_status'] ?? 'active',
        'lot_status': product['lot_status'] ?? 'verified',
        'active_ingredients': product['active_ingredients'],
        'verified_at': DateTime.now().millisecondsSinceEpoch,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

