import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/constant/app_colors.dart';

class DrawerListView extends GetView<HomePageController> {
  const DrawerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: controller.drawerDataList[index].onTap,
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.secondaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                          blurStyle: BlurStyle.normal)
                    ],
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(
                  controller.drawerDataList[index].icon,
                  color: AppColors.white,
                  size: 18.73,
                ),
              ),
              title: Text(
                controller.drawerDataList[index].text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 17),
              ),
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 30,
            ),
        itemCount: 5);
  }
}
