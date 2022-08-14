import 'package:flutter/material.dart';
import 'package:my_wallet/view/screens/settings/core/notifications.dart';
import 'package:my_wallet/view/screens/settings/widgets/settings_list.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationFunctions.init(initScheduled: true);
      NotificationFunctions.listNotifications();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: const [
              SettingsList(
                title: 'Set Reminder',
                icon: Icons.notifications_active_outlined,
              ),
              SettingsList(
                title: 'Delete Reminder',
                icon: Icons.delete_outline,
              ),
              SettingsList(
                title: 'Reset App',
                icon: Icons.restore,
              ),
              SettingsList(
                title: 'About us',
                icon: Icons.info_outline,
              ),
              SettingsList(
                title: 'Share to Friends',
                icon: Icons.share_outlined,
              ),
            ],
          )),
    );
  }
}
