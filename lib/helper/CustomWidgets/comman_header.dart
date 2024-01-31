import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/images/header_bg_line.png",
                color: Theme.of(context).brightness == Brightness.dark
                    ? null
                    : Colors.white54,
                // width: MediaQuery.of(context).size.width * .8,
              ),
            ),
            Theme.of(context).brightness == Brightness.dark
                ? Image.asset(
                    "assets/images/header-bg.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  )
                : SizedBox(),
          ],
        ));
  }
}
