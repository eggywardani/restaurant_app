import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_services.dart';
import 'package:restaurant_app/data/background_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/notification/notification_helper.dart';
import 'package:restaurant_app/data/preference/preference_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/post_review_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/screens/splash_screen.dart';
import 'package:restaurant_app/themes/style.dart';
import 'package:restaurant_app/utils/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(apiServices: ApiServices()),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(apiServices: ApiServices()),
        ),
        ChangeNotifierProvider(
          create: (context) => PostReviewProvider(apiServices: ApiServices()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferenceProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        )
      ],
      child: MaterialApp(
        key: navigatorKey,
        title: "Restaurant App",
        debugShowCheckedModeBanner: false,
        routes: {
          DetailPage.route: (context) => DetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String)
        },
        theme: ThemeData(
            textTheme: myTextTheme,
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.blueGrey[50],
            )),
        home: SplashScreen(),
      ),
    );
  }
}
