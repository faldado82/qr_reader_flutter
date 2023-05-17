import 'package:flutter/material.dart';
import 'package:qr_reader_flutter/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel?> scans = [];

  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    // Asignar el ID de la DB al modelo
    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarAllScans() async {
    final scans = await DBProvider.db.getAllScan();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getsScansPorTipo(tipo);
    this.scans = [...scans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodosLosScans(String tipo) async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  borrarScanPorID(int id) async {
    await DBProvider.db.deleteScanByID(id);
    cargarAllScans();
  }
}
