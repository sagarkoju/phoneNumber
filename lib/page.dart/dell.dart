import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer in Flutter'),
      centerTitle: true,
      backgroundColor: Colors.red
      
      ,),
      body: Center(
        child: SfPdfViewer.asset("assets/srk.pdf")
      ),
    );
  }
}