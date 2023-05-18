import 'package:flutter/material.dart';
import 'package:qr_reader_flutter/widgets/custom_scan_list.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScanList(tipo: 'http');
  }
}