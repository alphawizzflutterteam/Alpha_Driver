import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/utilities/utils.dart';
import '../../../Provider/edit_profile_controller.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';

class EditConfirmPassword extends StatefulWidget {
  final bool forLogin;
  const EditConfirmPassword({super.key, required this.forLogin});

  @override
  State<EditConfirmPassword> createState() => _EditConfirmPasswordState();
}

class _EditConfirmPasswordState extends State<EditConfirmPassword> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  bool _isVisible = false;
  bool _isVisible1 = false;
  IconData _icon = Icons.visibility_off;
  IconData _icon1 = Icons.visibility_off;
  bool _checkValue = false;
  @override
  void dispose() {
    // editProfileController.passwordController.dispose();
    // editProfileController.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return BaseScaffold(
      title: 'Change Password',
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView(
          children: [
            // Container(
            //   child: Text(
            //     'Enter new password ',
            //     style: th.bodyLarge?.copyWith(
            //         fontSize: 26,
            //         fontWeight: FontWeight.w700,
            //         color: appColorBlack),
            //   ),
            // ),
            // SizedBox(height: 5),
            // Text(
            //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            //   style: th.bodySmall
            //       ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            !widget.forLogin
                ? Container()
                : CustomTextField(
                    obscureText: !_isVisible,
                    suffixIcon: _icon,
                    controller: editProfileController.oldPasswordController,
                    // prefixIcon: Icons.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    hintText: '',
                    onIconTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                        _icon = _isVisible
                            ? Icons.visibility
                            : Icons.visibility_off;
                      });
                    },
                    labelText: 'Enter Old password',
                    inputFormatters: [],
                  ),
            !widget.forLogin ? Container() : SizedBox(height: 15),
            CustomTextField(
              obscureText: !_isVisible,
              suffixIcon: _icon,
              controller: editProfileController.passwordController,
              // prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintText: '',
              onIconTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                  _icon = _isVisible ? Icons.visibility : Icons.visibility_off;
                });
              },
              labelText: 'Create New password',
              inputFormatters: [],
            ),
            SizedBox(height: 15),
            CustomTextField(
              obscureText: !_isVisible1,
              suffixIcon: _icon1,
              controller: editProfileController.confirmPasswordController,
              // prefixIcon: d.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              labelText: 'Confirm Password',
              onIconTap: () {
                setState(() {
                  _isVisible1 = !_isVisible1;
                  _icon1 =
                      _isVisible1 ? Icons.visibility : Icons.visibility_off;
                });
              },
              hintText: '',
              inputFormatters: [],
            ),
            SizedBox(height: 30),
            CustomButtonWidget(
                text: 'SAVE PASSWORD',
                onPressed: () {
                  if (!widget.forLogin) {
                    if (editProfileController.passwordController.text.isEmpty) {
                      Utils.showFlushBarWithMessage(
                          "Invalid new password!!!", context);
                    } else if (editProfileController
                        .confirmPasswordController.text.isEmpty) {
                      Utils.showFlushBarWithMessage(
                          "Invalid confirm password!!!", context);
                    } else if (editProfileController
                            .confirmPasswordController.text !=
                        editProfileController.passwordController.text) {
                      Utils.showFlushBarWithMessage(
                          "New password and confirm password should be same.",
                          context);
                    } else if (validatePassword(
                            editProfileController.passwordController.text) !=
                        null) {
                      showPasswordRequirementsDialog(context);
                    } else {
                      editProfileController.changePassword();
                    }
                  } else {
                    if (editProfileController
                        .oldPasswordController.text.isEmpty) {
                      Utils.showFlushBarWithMessage(
                          "Invalid old password!!!", context);
                    } else if (editProfileController
                        .passwordController.text.isEmpty) {
                      Utils.showFlushBarWithMessage(
                          "Invalid new password!!!", context);
                    } else if (editProfileController
                        .confirmPasswordController.text.isEmpty) {
                      Utils.showFlushBarWithMessage(
                          "Invalid confirm password!!!", context);
                    } else if (editProfileController
                            .confirmPasswordController.text !=
                        editProfileController.passwordController.text) {
                      Utils.showFlushBarWithMessage(
                          "New password and confirm password should be same.",
                          context);
                    } else if (validatePassword(
                            editProfileController.passwordController.text) !=
                        null) {
                      showPasswordRequirementsDialog(context);
                    } else {
                      editProfileController.verifyAndPutPassword();
                    }
                  }
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password.';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters.';
  }
  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter.';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter.';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number.';
  }
  if (!value.contains(RegExp(r'[!@#\$%^&*()_+{}|:<>?~]'))) {
    return 'Password must contain at least one special character.';
  }
  return null;
}

void showPasswordRequirementsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Password Requirements',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              '• Password must be at least 8 characters.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
            Text(
              '• Password must contain at least one lowercase letter & one uppercase letter.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
            Text(
              '• Password must contain at least one number.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
            Text(
              '• Password must contain at least one special character.\n',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
          ),
        ],
      );
    },
  );
}
