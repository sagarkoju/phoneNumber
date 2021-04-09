import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ShowBarcode extends StatefulWidget {
  @override
  _ShowBarcodeState createState() => _ShowBarcodeState();
}

class _ShowBarcodeState extends State<ShowBarcode> {
  String barcode = 'unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Barcode'),
        centerTitle: true,
        elevation: 1,
        brightness: Brightness.light,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarText(
              text: "Scan the result",
              color: Colors.blue,
              textScale: 4,
            ),
            SizedBox(
              height: 10,
            ),
            BarText(
              text: "$barcode",
              color: Colors.red,
              textScale: 4,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                color: Colors.red,
                child: Text('Scan Barcode'),
                textColor: Colors.white,
                onPressed: () {
                  barcodescan();
                }),
          ],
        ),
      ),
    );
  }

  Future<void> barcodescan() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.BARCODE);
      if (!mounted) return;
      setState(() {
        this.barcode = barcode;
      });
    } on PlatformException {
      barcode = "Error to failed on your mobile device ";
    }
  }
}

class BarText extends StatelessWidget {
  final String text;
  final Color color;
  final double textScale;

  const BarText({Key key, this.text, this.color, this.textScale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        textScaleFactor: textScale,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
