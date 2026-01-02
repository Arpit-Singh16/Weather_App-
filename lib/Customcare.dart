import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // For Clipboard

class CustomerCarePage extends StatelessWidget {
  final String phoneNumber = '+18001234567';

  CustomerCarePage({super.key});

  void copyPhoneNumber(BuildContext context) {
    Clipboard.setData(ClipboardData(text: phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone number copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Care'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'For Assistance, Call Us:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              SelectableText(
                phoneNumber,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => copyPhoneNumber(context),
                icon: const Icon(Icons.copy),
                label: const Text('Copy Number'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
