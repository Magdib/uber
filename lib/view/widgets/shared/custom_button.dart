import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/view/widgets/shared/bright_container.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.borderRadius,
    this.color,
    this.width,
    this.height,
    this.lowerOpacity,
  }) : super(key: key);
  final String text;
  final void Function()? onPressed;
  final double? borderRadius;
  final Color? color;
  final double? width;
  final double? height;
  final bool? lowerOpacity;
  @override
  Widget build(BuildContext context) {
    return BrightContainer(
      onPressed: onPressed,
      lowerOpacity: lowerOpacity,
      child: MaterialButton(
        disabledColor: AppColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius == null
              ? BorderRadius.circular(15)
              : BorderRadius.circular(borderRadius!),
        ),
        padding: EdgeInsets.symmetric(vertical: height ?? 17),
        minWidth: width ?? MediaQuery.of(context).size.width - 20,
        color: color ?? AppColors.secondaryColor,
        elevation: 15,
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
