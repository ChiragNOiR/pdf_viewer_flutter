import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pdf_viewer/data/styles/styles.dart';
import 'package:pdf_viewer/widgets/search_bar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late TextEditingController searchView;
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();

    searchView = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.grey,
          flexibleSpace: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 120, 0),
                child: SizedBox(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.appBarTitle,
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        searchTextController: searchView,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _searchResult = _pdfViewerController.searchText(
                            searchView.text,
                            searchOption: TextSearchOption.caseSensitive);
                        if (kIsWeb) {
                          setState(() {});
                        } else {
                          _searchResult.addListener(() {
                            if (_searchResult.hasResult) {
                              setState(() {});
                            }
                          });
                        }
                      },
                    ),
                    Visibility(
                      visible: _searchResult.hasResult,
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _searchResult.clear();
                            searchView.clear();
                          });
                        },
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      color: Colors.white,
                      itemBuilder: (context) => [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Print",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Download",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Feedback",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                      onSelected: (item) => {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: SfPdfViewer.file(
          File(
            widget.file.path,
          ),
          controller: _pdfViewerController,
          currentSearchTextHighlightColor: Colors.blue.withOpacity(0.6),
          otherSearchTextHighlightColor: Colors.blue.withOpacity(0.3),
        ),
      ),
    );
  }
}
