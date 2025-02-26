import 'package:dsr_clone/shared/routes/app_pages.dart';
import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shared/routes/app_routes.dart';

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.roboto().fontFamily,
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              foregroundColor: AppColors.white,
              // backgroundColor: AppColors.primary1,
              // shape: const CircleBorder(),
            ),
          ),
          appBarTheme: const AppBarTheme(
            color: AppColors.primary,
            titleTextStyle: TextStyle(color: AppColors.white, fontSize: 15.0),
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
          ),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.app,
        getPages: AppPages().routes,
      ),
    );
  }
}
