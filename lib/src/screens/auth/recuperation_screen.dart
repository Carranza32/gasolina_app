import 'package:flutter/material.dart';

class RecuperationScreen extends StatelessWidget {
  const RecuperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperation'),
      ),
      body: const Center(
        child: Text('Recuperation Screen'),
      ),
    );
  }
}