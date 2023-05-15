import 'package:flutter/material.dart';
import 'package:qr_reader_flutter/pages/home_page.dart';
import 'package:qr_reader_flutter/pages/mapa_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader App',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'mapa': (_) => const MapaPage(),
      },
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
