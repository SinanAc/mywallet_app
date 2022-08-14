import 'package:flutter/material.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/screens/settings/functions/settings_functions.dart';
import 'package:share_plus/share_plus.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 227, 227, 232),
        child: Icon(icon, color: kIndigoColor),
      ),
      onTap: () async {
        title == 'Set Reminder'
            ? SettingsFunctions.setReminder(context)
            : title == 'Delete Reminder'
                ? SettingsFunctions.deleteReminder(context)
                : title == 'Reset App'
                    ? SettingsFunctions.resetVerification(context)
                    : title == 'About us'
                        ? SettingsFunctions.about(context)
                        : await Share.share(
                            'https://play.google.com/store/apps/details?id=com.fouvty.mywallet');
      },
    );
  }
}
