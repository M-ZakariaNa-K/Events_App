import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class LoginDefultButton extends StatelessWidget {
  const LoginDefultButton({
    super.key,
    required this.buttonColor,
    required this.borderColor,
    @required this.textColor,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  final Color buttonColor;
  final Color? textColor;
  final Color borderColor;
  final String title;
  final dynamic? icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //Go to LOGIN PAGE

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ThemesStyles.borderradiusprimary + 20),
            side: BorderSide(color: borderColor, width: 2)),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const Text(''),
          Text(
            title,
            style: TextStyle(
                color: textColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? ThemesStyles.seconndTextColor
                        : ThemesStyles.textColor),
                fontSize: ThemesStyles.littelFontSize),
          ),
        ],
      ),
    );
  }
}
