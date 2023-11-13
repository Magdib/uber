import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/view/widgets/shared/bright_container.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    required this.icon,
    this.borderRadius,
    required this.onPressed,
    this.iconSize,
    this.leftIconPadding,
    this.topIconPadding,
  });
  final IconData icon;
  final double? iconSize;
  final double? borderRadius;
  final void Function() onPressed;
  final double? leftIconPadding;

  final double? topIconPadding;
  @override
  Widget build(BuildContext context) {
    return BrightContainer(
      onPressed: onPressed,
      lowerOpacity: true,
      blurRadius: 20,
      child: MaterialButton(
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          height: 40,
          minWidth: 40,
          color: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 40)),
          child: Padding(
            padding: EdgeInsets.only(
                left: leftIconPadding ?? 0, top: topIconPadding ?? 0),
            child: Icon(
              icon,
              color: AppColors.white,
              size: iconSize ?? 15,
            ),
          )),
    );
  }
}
