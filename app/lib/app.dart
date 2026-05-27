import 'package:flutter/material.dart';

class DyanaApp extends StatelessWidget {
  const DyanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dyana',
      home: Scaffold(body: Center(child: Text('Dyana'))),
    );
  }
}
