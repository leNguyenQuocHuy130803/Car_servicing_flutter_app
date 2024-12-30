import 'package:car_servicing/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, this.onPressed, required this.label,
  });
  final void Function()? onPressed;
  final String label;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      // width: MediaQuery.sizeOf(context).width*0.4,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),backgroundColor:kPrimaryContainerColor),
         child:  Text(label,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white))));
  }
}