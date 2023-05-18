import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_flutter/provider/scan_list_provider.dart';
import 'package:qr_reader_flutter/utils/utils.dart';

class CustomScanList extends StatelessWidget {
  final String tipo;
  const CustomScanList({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (context, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanPorID(scans[i]!.id!);
        },
        child: ListTile(
          leading: Icon(
            tipo == 'geo' ? Icons.map : Icons.compass_calibration,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i]!.valor),
          subtitle: Text(scans[i]!.id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () => launchInBrowser(context, scans[i]!),
        ),
      ),
    );
  }
}
