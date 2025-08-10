import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService(this.client);

  // Upload a file to Supabase Storage bucket
  Future<String?> uploadFile({
    required String bucket,
    required String path,
    required Uint8List fileBytes,
  }) async {
    try {
      // uploadBinary throws if failed, returns null on success
      await client.storage.from(bucket).uploadBinary(path, fileBytes).catchError((error) {;
        throw Exception('File upload failed: $error');
      });

      // Get public URL of uploaded file
      print('path : $path');
      final url = client.storage.from(bucket).getPublicUrl(path);
      return url;
    } catch (e) {
      // Handle and log upload error
      print('Upload failed: $e');
      return null;
    }
  }


  // Insert or update data in a Supabase table
  Future<void> upsertData({
    required String table,
    required Map<String, dynamic> data,
    String? conflictTarget, // column(s) to check for conflict, e.g. "id"
  }) async {
    try {
      await client
          .from(table)
          .upsert(data, onConflict: conflictTarget)
          .select(); // returns the updated/inserted row
    } catch (e) {
      print('Data upsert failed: $e');
      throw Exception('Data upsert failed: $e');
    }
  }
  Future<Map<String, dynamic>?> getRowById({
    required String table,
    required int id,
  }) async {
    try {
      final response = await client
          .from(table)
          .select()
          .eq('id', id)
          .maybeSingle(); // returns the row or null

      return response;
    } catch (e) {
      print('Error fetching row by id: $e');
      throw Exception('Failed to fetch row by id: $e');
    }
  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    try {
      // Fetch file bytes from the URL
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to download file: ${response.statusCode}');
      }

      // Get local directory - for Windows, use getApplicationSupportDirectory or getDownloadsDirectory
      final directory = await getApplicationSupportDirectory();

      // Or for user Downloads folder (Windows only):
      // final directory = await getDownloadsDirectory();
      // But note getDownloadsDirectory() is only available on some platforms

      // Create local file path
      final filePath = path.join(directory.path, fileName);

      // Write file bytes to local file
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Return local file URI string (file:///C:/...)
      return file.uri.toString();
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }



}
