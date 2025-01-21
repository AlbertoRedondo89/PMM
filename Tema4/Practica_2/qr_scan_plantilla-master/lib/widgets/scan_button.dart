import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

/// Botón flotante que permite escanear códigos QR.
/// Utiliza el paquete `flutter_barcode_scanner` para leer
/// códigos y los procesa según el contenido del código escaneado.

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print('Botó polsat!');

        //String barcodeScanRes = 'geo:39.7259555,2.9110725';
        //String barcodeScanRes = 'https://paucasesnovescifp.cat/';

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);
        print(barcodeScanRes);

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        if (barcodeScanRes != null) {
          ScanModel nouScan = ScanModel(valor: barcodeScanRes);
          scanListProvider.nouScan(barcodeScanRes);
          launchUrl(context, nouScan);
        }
      },
    );
  }
}
