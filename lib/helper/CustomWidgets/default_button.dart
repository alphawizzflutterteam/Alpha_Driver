import 'package:flutter/material.dart';

import '../app_constant.dart';

class ButtonsWidgets extends StatefulWidget {
  final int index;
  final String buttonFirstText;
  final String buttonSecondText;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  const ButtonsWidgets({super.key, required this.index, required this.buttonFirstText, required this.buttonSecondText, required this.onPressed1, required this.onPressed2});

  @override
  State<ButtonsWidgets> createState() => _ButtonsWidgetsState();
}

class _ButtonsWidgetsState extends State<ButtonsWidgets> {

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    var th = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:widget.onPressed1,
          child: Container(
            height: 40,
            width: screenWidth*0.46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: widget.index==1? appButtonBg:appColorWhite,
            ),
            child:  Center(child:
            Text(widget.buttonFirstText,style: th.bodyMedium?.
            copyWith(
                fontWeight: FontWeight.w600,color: widget.index==1?appPrimaryColor:appButtonUnSelected
            ),)),
          ),
        ),
        GestureDetector(
          onTap: widget.onPressed2,
          child: Container(
            width: screenWidth*0.46,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: widget.index==2? appButtonBg:appColorWhite,
            ),
            child:  Center(child: Text(widget.buttonSecondText,style: th.bodyMedium?.
            copyWith(
                fontWeight: FontWeight.w600,color: widget.index==2?appPrimaryColor:appButtonUnSelected
            ),)),
          ),
        ),
      ],
    );
  }
}
