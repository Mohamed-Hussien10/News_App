import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemePreference(); // Ensure the theme is loaded when the app starts
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode; // Toggle the theme
    await _saveThemePreference(
        _isDarkMode); // Save preference to SharedPreferences
    notifyListeners(); // Notify listeners to update UI
  }

  // Load the saved theme preference
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode =
        prefs.getBool('isDarkMode') ?? false; // Default to false if not set
    notifyListeners();
  }

  // Save the theme preference
  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
