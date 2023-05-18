import 'package:flutter/material.dart';
import 'package:qr_reader_flutter/widgets/custom_scan_list.dart';

class HistoryMapasPage extends StatelessWidget {
  const HistoryMapasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScanList(tipo: 'geo');
  }
}
