import 'dart:typed_data';

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


  // Insert data into a Supabase table
  Future<void> insertData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    final response = await client.from(table).insert(data);

    if (response.error != null) {
      throw Exception('Insert failed: ${response.error!.message}');
    }
  }
}
