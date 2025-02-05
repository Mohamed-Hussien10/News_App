import 'package:blank_flutter_project/core/dependency_injection/di.dart';
import 'package:blank_flutter_project/core/helpers/app_localizations.dart';
import 'package:blank_flutter_project/core/helpers/bloc_observer_checker.dart';
import 'package:blank_flutter_project/core/helpers/notification_helper.dart';
import 'package:blank_flutter_project/core/routing/app_router.dart';
import 'package:blank_flutter_project/features/favorite_screen/data/favorite_notifier.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:blank_flutter_project/news_app.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:provider/provider.dart';

/// **WorkManager Callback Function** (Runs in the background)
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final newsService = NewsServices(Dio());
      List<NewsModels> news = await newsService.getTopHeadlines();

      if (news.isNotEmpty) {
        showNotification(
            news.first.title); // Show the latest news as a notification
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
    return Future.value(true);
  });
}

/// **Flutter Local Notifications Plugin**
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// **Show Local Notification**
void showNotification(String message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'daily_news_channel',
    'Daily News',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Daily News Update',
    message,
    platformChannelSpecifics,
  );
}

/// **Main Entry Point**
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Ensure proper initialization
  await ScreenUtil.ensureScreenSize();
  await NotificationHelper.initialize();
  await EasyLocalization.ensureInitialized();

  // Setup dependency injection & BLoC observer
  setupGetIt();
  Bloc.observer = const BlocObserverChecker();

  // Set device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize WorkManager for background news fetching
  Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  Workmanager().registerPeriodicTask(
    "daily_news_fetch",
    "fetchNewsDaily",
    frequency: const Duration(hours: 24),
  );

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalizations.supportedLocales,
      fallbackLocale: AppLocalizations.english,
      path: AppLocalizations.translationsPath,
      startLocale: AppLocalizations.english,
      saveLocale: true,
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MultiProvider(
          providers: [
            // Provide the FavoriteNotifier to the app
            ChangeNotifierProvider(create: (_) => FavoriteNotifier()),
          ],
          child: NewsApp(
            appRouter: AppRouter(),
          ),
        ),
      ),
    ),
  );
}
