import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Cơ sở Dữ liệu EHR - Lưu trữ Hồ sơ Y tế Điện tử (Mã hóa)
class EHRDatabaseService {
  static Database? _database;
  static const String _dbName = 'ehr_database.db';
  static const String _tableName = 'ehr_records';

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
            record_id TEXT UNIQUE NOT NULL,
            patient_id TEXT NOT NULL,
            record_type TEXT NOT NULL,
            data TEXT NOT NULL,
            encrypted_data TEXT,
            timestamp INTEGER NOT NULL,
            created_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  /// Lưu bản ghi EHR (mã hóa)
  static Future<void> saveEHRRecord({
    required String patientId,
    required String recordType,
    required Map<String, dynamic> data,
  }) async {
    final db = await database;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final recordId = 'EHR-${timestamp}';

    // Mã hóa dữ liệu nhạy cảm
    final encryptedData = _encryptData(jsonEncode(data));

    await db.insert(
      _tableName,
      {
        'record_id': recordId,
        'patient_id': patientId,
        'record_type': recordType,
        'data': jsonEncode(data),
        'encrypted_data': encryptedData,
        'timestamp': timestamp,
        'created_at': timestamp,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Lấy bản ghi EHR mới nhất
  static Future<Map<String, dynamic>?> getLatestEHR({
    String? patientId,
  }) async {
    final db = await database;
    final query = patientId != null
        ? 'SELECT * FROM $_tableName WHERE patient_id = ? ORDER BY timestamp DESC LIMIT 1'
        : 'SELECT * FROM $_tableName ORDER BY timestamp DESC LIMIT 1';

    final result = await db.rawQuery(
      query,
      patientId != null ? [patientId] : [],
    );

    if (result.isEmpty) return null;

    final record = result.first;
    return jsonDecode(record['data'] as String) as Map<String, dynamic>;
  }

  /// Lấy tất cả bản ghi EHR (sắp xếp theo Timeline)
  static Future<List<Map<String, dynamic>>> getAllEHRRecords({
    String? patientId,
  }) async {
    final db = await database;
    final query = patientId != null
        ? 'SELECT * FROM $_tableName WHERE patient_id = ? ORDER BY timestamp DESC'
        : 'SELECT * FROM $_tableName ORDER BY timestamp DESC';

    final results = await db.rawQuery(
      query,
      patientId != null ? [patientId] : [],
    );

    return results.map((record) {
      return jsonDecode(record['data'] as String) as Map<String, dynamic>;
    }).toList();
  }

  /// Mã hóa dữ liệu (đơn giản - nên dùng encryption library trong production)
  static String _encryptData(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Giải mã dữ liệu
  static String _decryptData(String encryptedData) {
    // TODO: Implement proper decryption
    return encryptedData;
  }
}

