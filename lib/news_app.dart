import 'package:blank_flutter_project/core/routing/app_routes.dart';
import 'package:blank_flutter_project/core/themes/app_colors.dart';
import 'package:blank_flutter_project/core/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/routing/app_router.dart';
import 'features/setting_screen/data/theme_provider.dart'; // Import ThemeProvider

class NewsApp extends StatelessWidget {
  final AppRouter appRouter;

  const NewsApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    // Fetch the current theme mode from the provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'My App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light, // Light theme settings
        ),
        darkTheme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark, // Dark theme settings
        ),
        themeMode: themeProvider.isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light, // Toggle theme mode based on provider
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: AppRoutes.homeScreen,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => Utils.closeKeyboard,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child!,
            ),
          );
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
