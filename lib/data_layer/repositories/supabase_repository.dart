import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../services/supabase_services.dart';

class SupabaseRepository {
  final SupabaseService service;

  SupabaseRepository(this.service);

  Future<String?> uploadFileAndGetUrl(String bucket, String path, Uint8List bytes) async {
    return await service.uploadFile(bucket: bucket, path: path, fileBytes: bytes);
  }

  Future<void> addRecord(String table, Map<String, dynamic> data) async {
     await service.upsertData(table: table, data: data);
  }
  Future<Map<String,dynamic>?> getRowById(String table,int id) async {
    return await service.getRowById(table: table, id: id);
  }
  Future<String> downloadAndSaveFile(String url, String filename) async {
    return await service.downloadAndSaveFile( url,  filename);
  }

}
