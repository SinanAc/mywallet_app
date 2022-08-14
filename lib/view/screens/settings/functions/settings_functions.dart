import 'package:flutter/material.dart';
import 'package:my_wallet/controller/data_base/db_functions.dart';
import 'package:my_wallet/view/core/colors.dart';
import 'package:my_wallet/view/screens/settings/core/notifications.dart';

class SettingsFunctions {
  static setReminder(context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime == null) {
      return;
    } else {
      await NotificationFunctions.showNotification(
          title: 'You have a Reminder',
          body: "Did you add your transactions today? Start adding now",
          payload: 'reminder',
          selectedHour: selectedTime.hour,
          selectedMinute: selectedTime.minute);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            selectedTime.hour >= 12
                ? "You will get a reminder at ${selectedTime.hour > 12 ? selectedTime.hour - 12 : selectedTime.hour} : ${selectedTime.minute == 0 ? selectedTime.minute : selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute} PM"
                : "You will get a reminder at ${selectedTime.hour == 0 ? 12 : selectedTime.hour > 12 ? selectedTime.hour - 12 : selectedTime.hour}:${selectedTime.minute == 0 ? selectedTime.minute : selectedTime.minute < 10 ? '0${selectedTime.minute}' : selectedTime.minute} AM",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kGreyColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  static deleteReminder(context) async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Delete Reminder',
                style: TextStyle(
                  color: kRedColor,
                )),
            content: const Text(
                'Are you sure to want to delete? This action will delete your scheduled reminder !!'),
            actions: [
              TextButton(
                child: const Text('Cancel',
                    style: TextStyle(
                        color: kIndigoColor, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Delete',
                    style: TextStyle(
                        color: kIndigoColor, fontWeight: FontWeight.bold)),
                onPressed: () {
                  NotificationFunctions.deleteAllNotifications();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Reminder has been deleted',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: kGreyColor,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  static resetVerification(context) async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Reset !!',
              style: TextStyle(color: kRedColor),
            ),
            content: const Text(
                'Are you sure to want to reset? This action will clear all the data !!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        color: kIndigoColor, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                onPressed: () {
                  TransactionDB.instance.appReset(context);
                },
                child: const Text('Reset',
                    style: TextStyle(
                        color: kIndigoColor, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }

  static about(context) {
    showAboutDialog(
        context: context,
        applicationName: 'MyWallet',
        applicationVersion: 'version : 1.0.2',
        applicationIcon: SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Image.asset('assets/images/appLogoo.png')),
        applicationLegalese: '©2022 MyWallet',
        children: [
          const SizedBox(height: 10),
          const Text(
              'My Wallet is a simple app to manage your money easily. It is a free app and you can use it without any cost.'),
        ]);
  }
}
