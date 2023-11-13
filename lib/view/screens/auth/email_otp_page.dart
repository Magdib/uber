import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/auth_controller.dart';
import 'package:uber/core/functions/app_bars/auth_app_bar.dart';
import 'package:uber/core/routes/routes.dart';
import 'package:uber/view/widgets/auth/otp_page.dart';

class EmailOtpPage extends GetView<AuthController> {
  const EmailOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(context,
          "A code has been sent to\n${controller.emailController.text}"),
      body: const OtpPage(nextRoute: AppRoutes.authNamePageRoute),
    );
  }
}
