import 'package:flutter/material.dart';

AppBar authAppBar(BuildContext context, String title,
    {bool isRichText = false, String? subtitle, TextStyle? titleStyle}) {
  return AppBar(
    toolbarHeight: 100,
    titleSpacing: 30,
    automaticallyImplyLeading: false,
    title: isRichText
        ? RichText(
            text: TextSpan(children: [
            TextSpan(text: "$title\n", style: titleStyle),
            TextSpan(
                text: subtitle, style: Theme.of(context).textTheme.bodyMedium)
          ]))
        : Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 2),
          ),
    elevation: 0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  );
}
