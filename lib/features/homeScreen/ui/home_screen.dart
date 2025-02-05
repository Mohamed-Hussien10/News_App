import 'package:blank_flutter_project/features/favorite_screen/ui/favorite_screen.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/match_schedule_screen.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/news_screen.dart';
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
    const ProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.article),
        title: ("News"),
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.grey,
        iconSize: 30.0, // Change icon size
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.schedule),
        title: ("Matches"),
        activeColorPrimary: Colors.deepPurpleAccent,
        inactiveColorPrimary: Colors.grey,
        iconSize: 30.0, // Change icon size
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: ("Favorites"),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
        iconSize: 30.0, // Change icon size
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.purpleAccent,
        inactiveColorPrimary: Colors.grey,
        iconSize: 30.0, // Change icon size
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade400, // Light grey line color
            width: 1.5, // Thickness of the line
          ),
        ),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style12, // Style of the NavBar
    );
  }
}



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('User Profile and Settings'),
      ),
    );
  }
}
