import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/core/Routes/routes.dart';
import 'package:uber/core/constant/app_assets.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/view/widgets/shared/custom_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: AppSizes.appheight / 1.3,
                  width: AppSizes.appWidth,
                  decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.secondaryColor,
                            blurRadius: 20,
                            blurStyle: BlurStyle.outer)
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                ),
                Positioned(
                    left: AppSizes.appWidth / 3,
                    top: 100,
                    child: Image.asset(
                      AppAssets.uberTitleImage,
                      height: 42,
                      width: 122,
                    )),
                Positioned(
                    left: AppSizes.appWidth / 3,
                    top: 160,
                    child: Text("Get there.",
                        style: Theme.of(context).textTheme.titleLarge!)),
                Positioned(
                    left: 0,
                    bottom: AppSizes.appheight / 6.5,
                    child: Image.asset(
                      AppAssets.startCarImage,
                      width: 444,
                      height: 296,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CustomButton(
                text: "Get Started",
                onPressed: () => Get.offNamed(AppRoutes.phoneNumberPageRoute)),
          )
        ],
      ),
    );
  }
}
