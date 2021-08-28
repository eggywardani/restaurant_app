import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<PreferenceProvider>(
      builder: (context, provider, child) => ListView(
        children: [
          Material(
            child: ListTile(
              title: Text('Scheduling Restaurants'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, child) {
                  return Switch.adaptive(
                    value: provider.isDailyActive,
                    onChanged: (value) async {
                      scheduled.scheduledRestaurant(value);
                      provider.enableDailyRestaurant(value);
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
