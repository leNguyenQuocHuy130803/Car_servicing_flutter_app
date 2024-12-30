import 'package:car_servicing/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, required this.label, this.errorText, this.onChanged, this.isPass=false, this.inputType=TextInputType.emailAddress, required this.hint, this.controller,
  });
  final String hint;
  final String label;
  final String? errorText;
  final void Function(String)? onChanged;
  final bool isPass;
  final TextInputType? inputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: inputType,
      obscureText: isPass,
      style: const TextStyle(fontSize: 22,color: kTextColor),
      decoration: InputDecoration(
        hintText: hint,
        // contentPadding:
        //       const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        fillColor: Colors.grey.withOpacity(0.2),filled: true,
        label:  Text(label,style: const TextStyle( color: kTextColor,
            fontSize: 22),),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: 16),
        border:   OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kTextColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kTextColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          errorBorder:   OutlineInputBorder(
            borderSide:  const BorderSide(color: Colors.red,width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red,width: 2),
            borderRadius: BorderRadius.circular(8)
          )
      ),
    );
  }
}