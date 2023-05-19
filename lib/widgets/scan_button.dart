import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_flutter/provider/scan_list_provider.dart';
import 'package:qr_reader_flutter/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        //const String barcodeScanRes = 'http://flutter.com';
        //const String barcodeScanRes = 'geo:-34.907970,-56.193387';

        if (barcodeScanRes == '-1') return;

        //if (context.mounted) return;
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        //if (context.mounted) return;

        debugPrint(barcodeScanRes);

        launchInBrowser(context, nuevoScan);
      },
    );
  }
}
