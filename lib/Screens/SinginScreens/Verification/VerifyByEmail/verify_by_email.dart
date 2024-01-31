import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work/Screens/SinginScreens/Verification/VerifyByEmail/otp_verify_by_email.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import 'package:work/helper/CustomWidgets/custom_text_field.dart';

import '../../../../helper/app_constant.dart';

class VerifyByEmail extends StatefulWidget {
  const VerifyByEmail({super.key});

  @override
  State<VerifyByEmail> createState() => _VerifyByEmailState();
}

class _VerifyByEmailState extends State<VerifyByEmail> {
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Verify Email',
            style: th.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w700, color: appColorBlack),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.image)),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Enter your mobile \nnumber',
                style: th.bodyLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: appColorBlack),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'We have sent the 4 digit verification code',
              style: th.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500, color: appColorBlack),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            CustomTextField(
              controller: emailController,
              labelText: 'Email id',
              hintText: 'emapl@gmail.com',
              inputFormatters: [],
            ),
            SizedBox(height: 20),
            CustomButtonWidget(
                text: 'SEND',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpVerifyByEmail()));
                }),
          ],
        ),
      ),
    );
  }
}
