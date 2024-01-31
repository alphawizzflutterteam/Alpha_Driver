import 'package:flutter/material.dart';
import 'package:work/helper/app_constant.dart';

class BottomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final String buttonText1;
  final String buttonText2;
  final bool isScan;
  const BottomButtonWidget({
    super.key,
    required this.onPressed1,
    required this.onPressed2,
    required this.buttonText1,
    required this.buttonText2,
    this.isScan = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onPressed1,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                child: Center(
                  child: Text(
                    buttonText1,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appColorBlack,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: onPressed2,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: appPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green, width: 0.5),
                ),
                child: Center(
                  child: Text(
                    buttonText2,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: appColorWhite,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
