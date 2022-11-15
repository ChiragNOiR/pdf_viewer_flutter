import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_viewer/data/service/api_service.dart';

final pdfViewerProvider = Provider(
  (ref) => ApiService(),
);
