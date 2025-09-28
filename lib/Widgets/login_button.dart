import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

import '../Model/custom_color.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text("Or",style: TextStyle(fontSize: 20,color: CustomColors.dried),),
        ),
        AuthButtonGroup(
          style: AuthButtonStyle(
            progressIndicatorColor: Colors.blue,
            progressIndicatorValueColor: Colors.grey[300],
            progressIndicatorStrokeWidth: 2.0,
            progressIndicatorValue: 1.0,
            width: 50,
            height: 50,
            progressIndicatorType: AuthIndicatorType.linear,
          ),
          buttons: [
            GoogleAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                splashColor: Colors.yellow,
                buttonType: AuthButtonType.icon,
              ),
            ),
            MicrosoftAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                splashColor: Colors.green,
                buttonType: AuthButtonType.icon,
              ),
            ),
            FacebookAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                splashColor: Colors.blue,
                buttonType: AuthButtonType.icon,
              ),
            ),

          ],
        ),

      ],
    );
  }
}
