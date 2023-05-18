import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_flutter/pages/direcciones_page.dart';
import 'package:qr_reader_flutter/pages/history_mapas_page.dart';
import 'package:qr_reader_flutter/provider/db_provider.dart';
import 'package:qr_reader_flutter/provider/scan_list_provider.dart';
import 'package:qr_reader_flutter/provider/ui_provider.dart';
import 'package:qr_reader_flutter/widgets/custom_bottom_navigation_bar.dart';
import 'package:qr_reader_flutter/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);

              scanListProvider.borrarTodosLosScans();
              print('registros eliminados');
            },
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtener el selected menu index del provider
    final uiProvider = Provider.of<UiProvider>(context);

    // se cambia para mostrar la pagina en la que se haga tap
    final currentIndex = uiProvider.selectedMenuIndex;

    // temporal leer la base de datos
    // CREATE DB_PROVIDER Metodo simple o rapido
    //final tempScan = ScanModel(valor: 'http://hola.com');
    //DBProvider.db.nuevoScan(tempScan);

    // CREATE DB_PROVIDER Metodo Raw (crudo o a mano)
    //final tempScanRaw = ScanModel(valor: 'http://ScanRaw.com');
    //DBProvider.db.nuevoScanRaw(tempScanRaw);

    // Get by ID
    //DBProvider.db.getScanById(17).then((scan) => print(scan?.valor));

    // Get all Scans
    //DBProvider.db.getAllScan().then(print);

    //Delete All
    //DBProvider.db.deleteAllScans().then(print);

    // Usar el Scan List Provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const HistoryMapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesPage();
      default:
        const HistoryMapasPage();
    }
    return const Placeholder();
  }
}
