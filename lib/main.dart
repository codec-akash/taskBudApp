import 'package:Taskbud/pages/splash_screen.dart';
import 'package:Taskbud/providers/auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:Taskbud/pages/login_page.dart';
import 'package:Taskbud/pages/home_page.dart';

import 'Utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(builder: (context, notifier, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: Auth(),
            ),
          ],
          child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
              title: "Task Bud",
              theme: notifier.darkTheme ? dark : light,
              home: auth.isAuth
                  ? HomePage()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authSnapShot) =>
                          authSnapShot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : LoginPage(),
                    ),
            ),
          ),
        );
      }),
    );
  }
}
