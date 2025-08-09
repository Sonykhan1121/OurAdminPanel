import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';

import '../../../data_layer/repositories/supabase_repository.dart';
import '../../../utils/enum/supabaseStatus.dart';

class SupabaseViewModel extends ChangeNotifier {
  final SupabaseRepository repository;

  SupabaseStatus _status = SupabaseStatus.initial;
  String? _errorMessage;
  String? _uploadedFileUrl;

  SupabaseViewModel(this.repository);

  SupabaseStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String? get uploadedFileUrl => _uploadedFileUrl;

  Future<void> uploadFile({
    required String bucket,
    required String path,
    required Uint8List fileBytes,
  }) async {
    _status = SupabaseStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = await repository.uploadFileAndGetUrl(bucket, path, fileBytes);
      _uploadedFileUrl = url;
      _status = SupabaseStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _status = SupabaseStatus.error;
    }
    notifyListeners();
  }

  Future<void> insertData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    _status = SupabaseStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.addRecord(table, data);
      _status = SupabaseStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _status = SupabaseStatus.error;
    }
    notifyListeners();
  }
}