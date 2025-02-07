import 'package:blank_flutter_project/features/favorite_screen/ui/favorite_screen.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/match_schedule_screen.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/news_screen.dart';
import 'package:blank_flutter_project/features/setting_screen/ui/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final List<Widget> _screens = [
    const NewsScreen(),
    const MatchScheduleScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.article),
        title: ("News"),
        activeColorPrimary: isDarkMode ? Colors.blueAccent : Colors.blueAccent,
        inactiveColorPrimary: isDarkMode ? Colors.white60 : Colors.grey,
        iconSize: 30.0,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.schedule),
        title: ("Matches"),
        activeColorPrimary:
            isDarkMode ? Colors.deepPurpleAccent : Colors.deepPurpleAccent,
        inactiveColorPrimary: isDarkMode ? Colors.white60 : Colors.grey,
        iconSize: 30.0,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: ("Favorites"),
        activeColorPrimary: isDarkMode ? Colors.redAccent : Colors.redAccent,
        inactiveColorPrimary: isDarkMode ? Colors.white60 : Colors.grey,
        iconSize: 30.0,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Profile"),
        activeColorPrimary: isDarkMode ? Colors.teal : Colors.teal,
        inactiveColorPrimary: isDarkMode ? Colors.white60 : Colors.grey,
        iconSize: 30.0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: isDarkMode
          ? Colors.black
          : Colors.white, // Change background color based on theme
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? Colors.grey.shade700
                : Colors.grey.shade400, // Adjust border color for dark mode
            width: 1.5,
          ),
        ),
        colorBehindNavBar: isDarkMode
            ? Colors.black
            : Colors.white, // Adjust color behind the NavBar
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }
}
