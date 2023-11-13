import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/auth_controller.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/view/widgets/shared/custom_text_form_filed.dart';

import '../shared/custom_button.dart';

class OtpPage extends GetView<AuthController> {
  const OtpPage({
    super.key,
    required this.nextRoute,
  });

  final String nextRoute;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPopPhoneNumber(),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: AppSizes.appWidth,
                  height: 73,
                  child: Center(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.focusList.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                      itemBuilder: (context, index) => Container(
                        height: 73,
                        width: 51,
                        padding: const EdgeInsets.only(top: 7.5),
                        decoration: BoxDecoration(
                            color: AppColors.otpBoxColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: CustomTextFormFiled(
                          disableBorder: true,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          fontsSize: 24,
                          focusNode: controller.focusList[index],
                          onChanged: (val) =>
                              controller.otpChanged(context, val, index),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    child: Text(
                      "Send another code",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () => log("Send Another Verification Code"),
                  ),
                )
              ],
            ),
          ),
          GetBuilder<AuthController>(
            builder: (controller) => Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
              child: CustomButton(
                  text: "Next",
                  onPressed: controller.canNavigate
                      ? () => Get.toNamed(nextRoute)
                      : null),
            ),
          )
        ],
      ),
    );
  }
}
