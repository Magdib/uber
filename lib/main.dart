import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/core/routes/routes.dart';
import 'package:uber/core/theme/theme.dart';

import 'core/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const UberApp());
}

class UberApp extends StatelessWidget {
  const UberApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: routes,
      theme: AppTheme.theme,
      locale: const Locale("en"),
      debugShowCheckedModeBanner: false,
    );
  }
}
