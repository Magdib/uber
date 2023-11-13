import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    this.controller,
    this.maxLength,
    this.keyboardType,
    this.validator,
    this.textAlign,
    this.disableBorder,
    this.focusNode,
    this.onChanged,
    this.fontsSize,
  });

  final TextEditingController? controller;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final bool? disableBorder;
  final void Function(String)? onChanged;
  final double? fontsSize;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        maxLength: maxLength,
        controller: controller,
        focusNode: focusNode,
        textAlign: textAlign ?? TextAlign.start,
        keyboardType: keyboardType,
        style: fontsSize != null
            ? Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: fontsSize)
            : Theme.of(context).textTheme.bodyMedium,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
            counterText: '',
            enabledBorder: disableBorder != true
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor))
                : InputBorder.none,
            border: disableBorder != true ? null : InputBorder.none));
  }
}
