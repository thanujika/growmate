import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Marketplace Screen\n(Buy/Sell Seeds & Fertilizer)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}