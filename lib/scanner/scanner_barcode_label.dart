import 'package:flutter/material.dart';
import 'package:interstellar/pages/send_money.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedBarcodeLabel extends StatefulWidget {
  const ScannedBarcodeLabel({
    Key? key,
    required this.barcodes,
  }) : super(key: key);

  final Stream<BarcodeCapture> barcodes;

  @override
  _ScannedBarcodeLabelState createState() => _ScannedBarcodeLabelState();
}

class _ScannedBarcodeLabelState extends State<ScannedBarcodeLabel> {
  bool isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BarcodeCapture>(
      stream: widget.barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (snapshot.hasData && scannedBarcodes.isNotEmpty && scannedBarcodes.first.displayValue != null && !isNavigating) {
          isNavigating = true; 
          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SendMoney(
                  name: "name",
                  avatar: "assets/images/avatar-1.png", 
                  qr_data: scannedBarcodes.first.displayValue!,
                ),
              ),
            ).then((_) {
              isNavigating = false;
            });
          });
        }

        return Container(
          child: Center(
            child: Text(
              'Scanning QR code...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
