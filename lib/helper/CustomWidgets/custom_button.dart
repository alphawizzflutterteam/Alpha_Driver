import 'package:flutter/material.dart';
import 'package:work/helper/app_constant.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enable;

  CustomButtonWidget({super.key, required this.text, required this.onPressed,  this.enable=true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: enable?appPrimaryColor:Colors.grey, // Set your desired button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: appColorWhite),
        ),
      ),
    );
  }
}
