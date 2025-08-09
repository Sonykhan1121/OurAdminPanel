import 'dart:typed_data';

import '../services/supabase_services.dart';

class SupabaseRepository {
  final SupabaseService service;

  SupabaseRepository(this.service);

  Future<String?> uploadFileAndGetUrl(String bucket, String path, Uint8List bytes) async {
    return await service.uploadFile(bucket: bucket, path: path, fileBytes: bytes);
  }

  Future<void> addRecord(String table, Map<String, dynamic> data) async {
    await service.insertData(table: table, data: data);
  }
}
