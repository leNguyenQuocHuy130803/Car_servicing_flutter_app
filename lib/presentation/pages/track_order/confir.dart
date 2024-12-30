import 'package:flutter/material.dart';

import '../Home.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  void _goToHome(BuildContext context) {
    // Navigate to the home screen. Modify this depending on your app's home screen route.
    // Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    Navigator.of(context).pushNamedAndRemoveUntil(Home.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: const Text(
          'Confirmation',
          style: TextStyle(color: Colors.black54),
        ),
        // centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success illustration
              Image.asset(
                'assets/images/success_illustration.png',
                // Replace with your own image asset path
                height: 150,
              ),
              const SizedBox(height: 24),
              const Text(
                'Order was placed Successfully!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "We've received your order and our team is working to get it to you as quick and safe as possible.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _goToHome(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'GO TO HOME',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
