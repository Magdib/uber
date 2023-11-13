import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/auth_controller.dart';
import 'package:uber/core/functions/app_bars/auth_app_bar.dart';
import 'package:uber/core/validation/validation.dart';
import 'package:uber/view/widgets/shared/custom_button.dart';
import 'package:uber/view/widgets/shared/custom_text_form_filed.dart';

class EmailCheckPage extends GetView<AuthController> {
  const EmailCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(context, 'Enter your e-mail'),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Center(
                  child: Form(
                    key: controller.emailFormState,
                    child: CustomTextFormFiled(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => emailValidator(val!),
                    ),
                  ),
                ),
              ),
            ),
            CustomButton(
              text: "Accept & Continue",
              onPressed: () => controller.navigateToEmailOtp(),
            )
          ],
        ),
      ),
    );
  }
}
