import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:work/helper/CustomWidgets/custom_button.dart';
import '../../../../helper/CustomWidgets/otp_widget.dart';
import '../../../../helper/app_constant.dart';

class OtpVerifyByEmail extends StatefulWidget {
  const OtpVerifyByEmail({super.key});

  @override
  State<OtpVerifyByEmail> createState() => _OtpVerifyByEmailState();
}

class _OtpVerifyByEmailState extends State<OtpVerifyByEmail> {
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final th= Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(icon:const Icon(Icons.arrow_back_outlined),
          onPressed: () { Navigator.pop(context); },),
        title:  Text('Verify Email',style: th.bodyLarge?.
        copyWith(
            fontWeight: FontWeight.w700,color: appColorBlack
        ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.12,),
            const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.image)),
            const SizedBox(height: 20,),
            Container(
              child: Text('Enter your verification \ncode',style: th.bodyLarge?.
              copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,color: appColorBlack
              ),),
            ),
            const SizedBox(height: 5),
            Text('We the OTP sent to example@gmail.com',style: th.bodySmall?.
            copyWith(
                fontWeight: FontWeight.w500,color: appColorBlack
            ),),
            SizedBox(height: MediaQuery.of(context).size.height*0.08,),
            CustomOtpInput(
              length: 4,
              onCompleted: (otp) {
                print('Entered OTP: $otp');
              },
            ),
            const SizedBox(height: 20),
            CustomButtonWidget(text: 'VERIFY', onPressed: (){

            }),
            const SizedBox(height: 20),

            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Didn\'t recieved Otp? ',
                        style: th.bodySmall?.
                        copyWith(
                            fontWeight: FontWeight.w500,color: appColorBlack
                        ),
                      ),
                      TextSpan(
                        text: 'Resend OTP',
                        style: th.bodySmall?.
                        copyWith(
                            fontWeight: FontWeight.w700,color: appPrimaryColor
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Tapped on "!"');
                          },
                      ),
                    ]
                )),
          ],
        ),
      ),
    );
  }
}
