import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/auth_controller.dart';
import 'package:uber/core/functions/app_bars/auth_app_bar.dart';
import 'package:uber/core/validation/validation.dart';
import 'package:uber/view/widgets/shared/custom_button.dart';
import 'package:uber/view/widgets/shared/custom_text_form_filed.dart';

class AuthNamepage extends GetView<AuthController> {
  const AuthNamepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(context, "Great!",
          subtitle: "And last, what is your name?",
          isRichText: true,
          titleStyle: Theme.of(context).textTheme.titleLarge),
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
                    key: controller.nameFormState,
                    child: CustomTextFormFiled(
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      validator: (val) => nameValidator(val!),
                    ),
                  ),
                ),
              ),
            ),
            CustomButton(
              text: "Get a Uber Taxi",
              onPressed: () => controller.navigateToHomePage(context),
            )
          ],
        ),
      ),
    );
  }
}
