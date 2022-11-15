import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_viewer/data/provider/pdf_provider.dart';

final networkPdfProvider = FutureProvider.family<File, String>(
  (ref, url) => ref.read(pdfViewerProvider).loadNetwork(url),
);
