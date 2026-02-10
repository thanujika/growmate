import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Assistant AI'),
      ),
      body: const Center(
        child: Text(
          'AI Chatbot for Farming Support\nComing Soon!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}