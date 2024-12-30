import 'package:flutter/material.dart';

class snackbarMessage extends StatelessWidget {
  const snackbarMessage({
    super.key,
    required this.message,
    this.isError= true, required this.context, // Default to red color for error messages,
  });
  final String message;
  final bool isError;
  final BuildContext context;
  
  void show() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red[300] : Colors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Empty widget since we use `show()` directly
  }
}