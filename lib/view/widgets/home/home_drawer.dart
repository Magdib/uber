import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/constant/app_assets.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';

import 'drawer_list_view.dart';

class HomeDrawer extends GetView<HomePageController> {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: AppSizes.appWidth - 75,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 101,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryColor, width: 3),
                      borderRadius: BorderRadius.circular(50)),
                  child: GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: GetBuilder<HomePageController>(
                      builder: (controller) => Container(
                        height: 87,
                        width: 87,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: controller.userImage == AppAssets.anonymousPerson
                            ? Image.asset(
                                AppAssets.anonymousPerson,
                                height: 87,
                                width: 87,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(controller.userImage),
                                height: 87,
                                width: 87,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  controller.userName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  controller.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.white),
                )
              ],
            ),
            const Divider(
              color: AppColors.primaryColor,
              thickness: 2,
            ),
            const DrawerListView(),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
