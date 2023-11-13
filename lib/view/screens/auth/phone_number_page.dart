import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/auth_controller.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/core/functions/app_bars/auth_app_bar.dart';
import 'package:uber/core/validation/validation.dart';
import 'package:uber/view/widgets/shared/custom_button.dart';
import 'package:uber/view/widgets/shared/custom_text_form_filed.dart';

class PhoneNumberPage extends GetView<AuthController> {
  const PhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(context, "Enter your phone number"),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Form(
                    key: controller.phoneFormState,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 55,
                            child: CustomTextFormFiled(
                              maxLength: 4,
                              controller: controller.countryCodeController,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.end,
                              validator: (val) => countryCodeValidator(val!),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: AppSizes.appWidth / 1.7,
                            child: CustomTextFormFiled(
                              controller: controller.phoneNumberController,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              validator: (val) => phoneValidator(val!),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "By countinuing, I confirm I have \nread the  ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.white)),
                    TextSpan(
                        text: "Privacy Policy",
                        recognizer: controller.privacyPolicyTap,
                        style: Theme.of(context).textTheme.bodySmall)
                  ])),
                ],
              ),
            ),
            CustomButton(
                text: "Accept & Continue",
                onPressed: () => controller.navigateToOtpPage())
          ],
        ),
      ),
    );
  }
}
