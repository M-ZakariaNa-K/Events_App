// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  const ProfileButtonWidget({
    Key? key,
    required this.icon,
    required this.isPressed,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final bool isPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff2B2B2B)
            : const Color.fromARGB(255, 243, 243, 243),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
            color: ThemesStyles.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ThemesStyles.mainFontSize,
              ),
            ),
          ),
          const Spacer(),
          Icon(isPressed
              ? Icons.keyboard_arrow_down_outlined
              : Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
