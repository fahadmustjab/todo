import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:todo/Components/Themes.dart';
import 'package:todo/Services/ThemeServices.dart';
import 'package:todo/Services/NotifyServices.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? isDarkMode;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    super.initState();
    NotifyHelper.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: _appbar(brightness, context),
      body: Container(child: Text('Theme Data')),
    );
  }

  AppBar _appbar(Brightness brightness, BuildContext context) {
    return AppBar(
      leading: GestureDetector(
          onTap: () {
            ThemeServices().switchTheme();
            NotifyHelper.showBigTextNotification(
                title: "You bloody idiot",
                body: "Congo, you have got a message",
                fln: flutterLocalNotificationsPlugin);
          },
          child: Icon(context.isDarkMode ? Icons.light_mode : Icons.dark_mode)),
      actions: [
        Icon(Icons.person),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
