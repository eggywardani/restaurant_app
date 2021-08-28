import 'package:flutter/material.dart';
import 'package:restaurant_app/data/notification/notification_helper.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/screens/favorite_page.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/screens/settings_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;
  List<Widget> _listWidget = [HomePage(), FavoritePage(), SettingsPage()];
  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomNavBarItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(DetailPage.route);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItem,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
