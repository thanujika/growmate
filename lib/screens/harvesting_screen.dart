import 'package:flutter/material.dart';

class HarvestingScreen extends StatelessWidget {
  const HarvestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harvesting Services'),
      ),
      body: const Center(
        child: Text(
          'Harvesting Machinery Booking\nComing Soon!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}