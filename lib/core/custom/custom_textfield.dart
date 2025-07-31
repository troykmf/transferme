import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transferme/core/util/app_color.dart';
import 'package:transferme/core/util/app_responsive_helper.dart';
import 'package:transferme/core/util/app_style.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.text,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    required this.autocorrect,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.hintText,
  });

  final String text;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool autocorrect;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String?>? validator;
  final Widget? suffixIcon;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
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
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: headlineText(
            12,
            _isFocused ? AppColor.primaryColor : AppColor.textLightGreyColor,
            null,
          ),
        ),
        Gap(5),
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: mediumText(11.5, AppColor.textLightGreyColor, null),
            suffixIcon: widget.suffixIcon,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.height(10),
            ),
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.lightGreyColor,
                // width: 0.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                // width: 0.5,
              ),
            ),
          ),
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          onChanged: widget.onChanged,
          validator: widget.validator,
          style: headlineText(13, AppColor.blackColor, null),
        ),
      ],
    );
  }
}
