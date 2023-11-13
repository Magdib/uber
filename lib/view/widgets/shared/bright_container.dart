import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';

class BrightContainer extends StatelessWidget {
  const BrightContainer(
      {super.key,
      required this.child,
      this.onPressed,
      this.blurRadius,
      this.lowerOpacity});
  final Widget child;
  final void Function()? onPressed;
  final double? blurRadius;
  final bool? lowerOpacity;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: onPressed != null
            ? [
                BoxShadow(
                    color: lowerOpacity == null
                        ? AppColors.secondaryColor
                        : AppColors.secondaryColor.withOpacity(0.3),
                    blurRadius: blurRadius ?? 10,
                    offset: const Offset(0, 5),
                    blurStyle: BlurStyle.normal)
              ]
            : null,
      ),
      child: child,
    );
  }
}
