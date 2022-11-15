import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_viewer/data/provider/components/network_pdf_provider.dart';
import 'package:pdf_viewer/data/service/api_service.dart';
import 'package:pdf_viewer/data/styles/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf_viewer/ui/screens/pdf_view.dart';
import 'package:pdf_viewer/widgets/search_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

void openFile(PlatformFile file) {
  OpenFile.open(file.path);
}

class _HomePageState extends ConsumerState<HomePage> {
  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PDFViewerPage(file: file),
        ),
      );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController networkTextController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PDF Viewer',
            style: AppStyle.appBarTitle,
          ),
          backgroundColor: AppStyle.black,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 150, 34, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Display PDF from your local storage: ',
                  style: AppStyle.text,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: MaterialButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                          allowMultiple: false);
                      if (result == null) return;

                      final file = result.files.first;
                      openFile(file);
                    },
                    color: AppStyle.black,
                    child: Text(
                      'Select',
                      style: AppStyle.button,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Display PDF from Network URL:   ',
                  style: AppStyle.text,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: Form(
                    key: _formKey,
                    child: SearchBar(
                      searchTextController: networkTextController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Search Bar is Empty.';
                        } else if (!value.contains("http")) {
                          return 'Enter valid URL.';
                        } else if (!value.contains(".pdf")) {
                          return 'Enter valid URL.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 110),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final url = networkTextController.text;
                        final file = ref.read(networkPdfProvider(url));
                        file.when(
                          error: (error, stackTrace) => const Icon(Icons.error),
                          loading: () => Center(
                            child: CircularProgressIndicator(
                              color: AppStyle.black,
                            ),
                          ),
                          data: (file) => openPDF(context, file),
                        );
                      }
                    },
                    color: AppStyle.black,
                    child: Text(
                      'View PDF',
                      style: AppStyle.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
