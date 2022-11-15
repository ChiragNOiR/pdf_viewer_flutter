import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final data = response.bodyBytes;

    return _storeFile(url, data);
  }

  Future<File> _storeFile(String url, Uint8List data) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(data, flush: true);
    return file;
  }
}
