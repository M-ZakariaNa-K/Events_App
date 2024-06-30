import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class DefaultFormFeild extends StatelessWidget {
  const DefaultFormFeild({
    super.key,
    required this.textEditingController,
    required this.validator,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.autoFoucs,
    this.onSubmitted,
    this.iniValue,
    this.textInputType,
  });

  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final VoidCallback? onSubmitted;
  final String? hintText;
  final bool? obscureText;
  final Icon? prefixIcon;
  final bool? autoFoucs;
  final String? iniValue;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        onFieldSubmitted: (value) {
          if (onSubmitted != null) onSubmitted!();
        },
        controller: textEditingController,
        enableSuggestions: false,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: obscureText!,
        textInputAction: TextInputAction.next,
        cursorColor: ThemesStyles.primary,
        validator: validator,
        autofocus: autoFoucs!,
        initialValue: iniValue,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
                color: ThemesStyles.textColor.withAlpha(80),
                fontSize: ThemesStyles.mainFontSize - 2),
            floatingLabelStyle: TextStyle(
              color: ThemesStyles.primary,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ThemesStyles.primary.withAlpha(80),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: ThemesStyles.primary,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: ThemesStyles.primary,
                ))),
      ),
    );
  }
}
//custom

class CustomSizedBox extends StatelessWidget {
  CustomSizedBox({
    super.key,
    this.plusheight = 0.0,
  });

  double plusheight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 13 + plusheight,
    );
  }
}
