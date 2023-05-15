import 'package:flutter/material.dart';
import 'package:qr_reader_flutter/pages/direcciones_page.dart';
import 'package:qr_reader_flutter/pages/history_mapas_page.dart';
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
            onPressed: () {},
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
    const currentIndex = 0;

    switch (currentIndex) {
      case 0:
        return const HistoryMapasPage();
      case 1:
        return const DireccionesPage();
      default:
        const HistoryMapasPage();
    }
    return const Placeholder();
  }
}
