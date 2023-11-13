import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/view/widgets/home/rounded_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        RoundedIconButton(
            icon: Icons.arrow_back_ios,
            borderRadius: 15,
            iconSize: 12,
            leftIconPadding: 4,
            onPressed: () => Get.back()),
        const SizedBox(
          width: 15,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
