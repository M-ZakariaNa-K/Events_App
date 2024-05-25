import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class CustomeLoginTextFormField extends StatefulWidget {
  const CustomeLoginTextFormField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.title,
    required this.controller,
    required this.validator,
    @required this.prefixIcon,
    @required this.isFilledTextFild,
    @required this.filledTextFildData,
  }) : super(key: key);

  final String hintText;
  final String title;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final bool? isFilledTextFild;
  final String? filledTextFildData;
  @override
  State<CustomeLoginTextFormField> createState() =>
      _CustomeLoginTextFormFieldState();
}

class _CustomeLoginTextFormFieldState extends State<CustomeLoginTextFormField> {
  bool _isPasswordVisible = false;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    if (widget.isFilledTextFild != null) {
      widget.controller.text = "${widget.filledTextFildData}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //1
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 15.0),
        //   child: Text(
        //     title,
        //     style: const TextStyle(
        //       color: ThemesStyles.textColor,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 18.0,
        //     ),
        //   ),
        // ),
        //2
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          keyboardType: widget.inputType,
          obscureText:
              widget.title == "Password" && !_isPasswordVisible ? true : false,
          cursorColor: ThemesStyles.primary, // Change cursor color
          style: TextStyle(
            color: ThemesStyles.textColor, // Change text color
            fontSize: ThemesStyles.littelFontSize, // Change text font size
          ),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            //  widget.title == "Password"
            //     ? const Icon(Icons.lock)
            //     :widget.title == "Email"? const Icon(Icons.email):null,
            suffixIcon: widget.title == "Password"
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )
                : null,
            fillColor:
                _isFocused ? ThemesStyles.thirdColor : const Color(0xffFAFAFb),
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 220, 220, 220), fontSize: 16),

            // Customize the border color and radius
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 2.0),
              borderRadius:
                  BorderRadius.circular(ThemesStyles.borderradiusprimary + 5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: ThemesStyles.primary, width: 2.0),
              borderRadius:
                  BorderRadius.circular(ThemesStyles.borderradiusprimary + 5),
            ),
            // Adjust the height of the TextField using contentPadding
            contentPadding: const EdgeInsets.all(15.0),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
