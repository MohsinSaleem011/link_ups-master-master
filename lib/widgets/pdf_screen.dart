import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as IO;

import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  final Map<String, dynamic> arg;
  PDFScreen({Key? key, required this.arg}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  bool isLoading = false;
  Uint8List? pdfByte;

  void getPolicy() {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('config')
        .doc('hHVpFZPwUyaVATLmcvPE')
        .snapshots()
        .listen((event) async {
      var pdfUrl = Uri.parse(event.data()?[widget.arg['key']]);
      final response = await http.get(pdfUrl);
      Uint8List byte = await response.bodyBytes;

      final dir = await getTemporaryDirectory();
      final file =
          IO.File("${dir.path}/${DateTime.now().microsecondsSinceEpoch}.pdf");

      await file.writeAsBytes(byte, flush: true);
      setState(() {
        pdfByte = byte;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text(widget.arg['key'] == 'privacy_policy'
            ? "privacy_policy".tr
            : 'term_condition'.tr),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: <Widget>[
          if (isLoading)
            Container(
                child: Center(
              child: CircularProgressIndicator.adaptive(),
            )),
          if (!isLoading)
            PDFView(
              pdfData: pdfByte,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
                  false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {},
              onPageChanged: (int? page, int? total) {
                setState(() {
                  currentPage = page;
                });
              },
            ),
        ],
      ),
    );
  }
}
