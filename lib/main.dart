import 'package:flutter/material.dart';
import 'package:Taskbud/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'Utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(builder: (context, notifier, child) {
        return MaterialApp(
          title: "Task Bud",
          theme: notifier.darkTheme ? dark : light,
          home: HomePage(),
        );
      }),
    );
  }
}
