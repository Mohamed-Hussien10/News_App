import 'package:blank_flutter_project/features/setting_screen/data/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Toggle
            ListTile(
              title: Text('dark_mode'.tr()),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(); // This triggers theme change
                },
              ),
            ),

            // Language Selection
            ListTile(
              title: Text('language'.tr()),
              trailing: DropdownButton<Locale>(
                value: Locale(
                  context.locale.languageCode,
                  context.locale.countryCode ?? '',
                ),
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    context.setLocale(newLocale);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: Locale('en', 'US'),
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: Locale('ar', 'EG'),
                    child: Text('العربية'),
                  ),
                ],
              ),
            ),

            // Notifications Toggle
            ListTile(
              title: Text('notifications'.tr()),
              trailing: Switch(
                value: isNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    isNotificationsEnabled = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
