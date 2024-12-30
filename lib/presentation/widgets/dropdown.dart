import 'package:car_servicing/constants.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.label,
    this.errorText,
    required this.items,
    this.onChanged,
    required this.hint,
    this.value,
    this.controller,
  });
  final String hint;
  final String label;
  final String? errorText;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  final String? value;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      items: items,
      onChanged: (String? newValue) {
        if (controller != null) {
          controller!.text = newValue ?? '';
        }
        if (onChanged != null) {
          onChanged!(newValue);
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.grey.withOpacity(0.2),
        filled: true,
        label: Text(label,
            style: const TextStyle(color: kTextColor, fontSize: 22)),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kTextColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
