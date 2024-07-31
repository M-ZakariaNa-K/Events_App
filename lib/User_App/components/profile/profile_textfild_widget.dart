// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';

class ProfileTextFildWidget extends StatelessWidget {
  const ProfileTextFildWidget({
    Key? key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.inputType,
    required this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType inputType;

  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 48, 48, 48)
              : const Color(0xffFAFAFA),
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 206, 206, 206)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    "assets/images/reset-password (3).png",
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xffFAFAFA)
                        : const Color.fromARGB(255, 48, 48, 48),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      // color: ThemesStyles.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomeTextFormField(
            hintText: hintText,
            inputType: inputType,
            title: "New Password",
            controller: controller,
            validator: validator,
            prefixIcon: null,
          ),
        ],
      ),
    );
  }
}
