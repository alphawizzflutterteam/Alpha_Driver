import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Screens/OrderScreens/cancelOrderConfirmation.dart';
import 'package:work/utilities/color.dart';

Future<void> showCancelDialog(BuildContext context, String orderId) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: CancelOrderDialogWidget(
            orderId: orderId,
          ));
    },
  );
}

class CancelOrderDialogWidget extends StatefulWidget {
  final String orderId;

  const CancelOrderDialogWidget({super.key, required this.orderId});

  @override
  State<CancelOrderDialogWidget> createState() =>
      _CancelOrderDialogWidgetState();
}

class _CancelOrderDialogWidgetState extends State<CancelOrderDialogWidget> {
  List<String> reasons = [
    'Incorrect delivery details',
    'Safety concerns or customer behavior',
    'Customer unavailability',
    'Customer refused to collect',
    'Technical Issues',
    'Personal Emergency'
  ];

//   1. Incorrect pickup details may result in order cancellations.
// 2. Safety concerns or customer behavior can lead to driver cancellations.
// 3. Customer unavailability may result in order cancellations.
// 4. Unresolved issues may cause customers to fail pickups, leading to cancellations.
// 5. Various reasons, beyond common ones, can prompt driver cancellations.

  String selectedReason = 'Incorrect delivery details';
  void handleOptionChange(String value) {
    setState(() {
      selectedReason = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83 * reasons.length.toDouble(),
      width: 700,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).brightness == Brightness.dark
            ? colors.overlayBG
            : Colors.white,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Cancel order reason',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 59 * reasons.length.toDouble(),
            child: Theme(
              data: ThemeData(unselectedWidgetColor: colors.greyText),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reasons.length,
                itemBuilder: (context, i) {
                  return Material(
                    color: Colors.transparent,
                    child: RadioListTile(
                      title: Text(
                        reasons[i],
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14,
                        ),
                        softWrap: false,
                      ),
                      activeColor: colors.buttonColor,
                      value: reasons[i],
                      groupValue: selectedReason,
                      onChanged: (value) {
                        handleOptionChange(value.toString());
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: colors.buttonColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Get.back();
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        content: CancelOrderPopup(
                          order_id: widget.orderId,
                          reason: selectedReason,
                        ));
                  },
                );
              },
              child: const Text('DONE'),
            ),
          ),
        ],
      ),
    );
  }
}
