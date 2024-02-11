import 'package:flutter/material.dart';

import 'package:hackthisfall/wrapper/auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.transparent, elevation: 0.0, titleSpacing: 10)),
      title: "Brainiacs",
      home: const AuthWrapper(),
    );
  }
}
