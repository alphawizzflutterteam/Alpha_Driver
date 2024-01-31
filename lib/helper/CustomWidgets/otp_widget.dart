import 'package:flutter/material.dart';

class CustomOtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;

  CustomOtpInput({required this.length, required this.onCompleted});

  @override
  _CustomOtpInputState createState() => _CustomOtpInputState();
}

class _CustomOtpInputState extends State<CustomOtpInput> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _controllers = List.generate(widget.length, (index) => TextEditingController());

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < widget.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }

        if (i == widget.length - 1 && _controllers[i].text.isNotEmpty) {
          String otp = _controllers.map((controller) => controller.text).join();
          widget.onCompleted(otp);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.length,
            (index) => Container(
              // margin: EdgeInsets.only(right: 25),
          width: 50,
          height: 50,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.all(16),
            ),
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.length; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }
}
