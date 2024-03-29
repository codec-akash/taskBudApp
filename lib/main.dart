import 'package:Taskbud/pages/reset_password.dart';
import 'package:Taskbud/pages/signup_page.dart';
import 'package:Taskbud/pages/splash_screen.dart';
import 'package:Taskbud/pages/updateApp/updateapp.dart';
import 'package:Taskbud/providers/auth.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';

import 'package:Taskbud/pages/login_page.dart';
import 'package:Taskbud/pages/home_page.dart';

import 'Utils/theme.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var androidInitialize = AndroidInitializationSettings('app_icon');
  var iosInitialize = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true);
  var initializeSettings =
      InitializationSettings(android: androidInitialize, iOS: iosInitialize);
  await flutterLocalNotificationsPlugin.initialize(
    initializeSettings,
    onSelectNotification: (payload) async {
      print(payload ?? "No Payload");
    },
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: ThemeNotifier(),
        ),
        ChangeNotifierProxyProvider<Auth, TaskProvider>(
          create: (context) {},
          update: (ctx, auth, previousTask) => TaskProvider(
            auth.token,
            previousTask == null ? [] : previousTask.tasks,
          ),
        ),
      ],
      child: Consumer2<Auth, ThemeNotifier>(
        builder: (ctx, auth, theme, _) => MaterialApp(
          title: "Task Bud",
          theme: theme.darkTheme ? dark : light,
          home: auth.isAuth
              ? UpdateApp(
                  child: HomePage(),
                )
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authSnapShot) =>
                      authSnapShot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : LoginPage(),
                ),
          routes: {
            SignUpPage.routeName: (ctx) => SignUpPage(),
            ResetPassword.routeName: (ctx) => ResetPassword(),
          },
        ),
      ),
    );
  }
}
