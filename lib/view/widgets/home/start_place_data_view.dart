import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';

class StartPlaceDataView extends StatelessWidget {
  const StartPlaceDataView({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 27.5),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: AppColors.green,
              ),
            ),
            const SizedBox(
              width: 12.5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
