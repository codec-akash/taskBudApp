import 'dart:io';

import 'package:Taskbud/Utils/global.dart';
import 'package:Taskbud/pages/updateApp/dontAskAgainBox.dart';
import 'package:Taskbud/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateApp extends StatefulWidget {
  final Widget child;

  UpdateApp({this.child});

  @override
  _UpdateAppState createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  bool isInit = true;
  String minVersion;
  String latestVersion;

  _lauchUrl() async {
    await launch(PLAY_STORE_URL);
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      final appData = Provider.of<Auth>(context);
      await appData.checkAppVersion();
      minVersion = appData.minVersion;
      latestVersion = appData.latestVersion;

      checkLatestVersion(context);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  checkLatestVersion(context) async {
    await Future.delayed(Duration(seconds: 5));
    Version minAppVersion = Version.parse(minVersion);
    Version latestAppVersion = Version.parse(latestVersion);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Version currentAppVersion = Version.parse(packageInfo.version);

    print("VERSION $minAppVersion");

    if (minAppVersion > currentAppVersion) {
      _showCompulsoryUpdateDialog(context, "Please update the app to continue");
    } else if (latestAppVersion > currentAppVersion) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      bool showUpdates = false;
      showUpdates = sharedPreferences.getBool(updateShared);
      if (showUpdates != null && showUpdates == false) {
        return;
      }
      _showOptionalUpdateDialog(
        context,
        "A newer version of the app is available",
      );
      print('Update available');
    } else {
      print('App is up to date');
    }
  }

  _showOptionalUpdateDialog(context, String message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = "App Update Available";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        String btnLabelDontAskAgain = "Don't ask me again";
        return WillPopScope(
          onWillPop: () async => false,
          child: DoNotAskAgainDialog(
            updateShared,
            title,
            message,
            btnLabel,
            btnLabelCancel,
            _onUpdateNowClicked,
            doNotAskAgainText:
                Platform.isIOS ? btnLabelDontAskAgain : 'Never ask again',
          ),
        );
      },
    );
  }

  _onUpdateNowClicked() {
    _lauchUrl();
  }

  _showCompulsoryUpdateDialog(context, String message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String title = 'App Update available';
        String btnLabel = "Update Now";
        return Platform.isIOS
            ? WillPopScope(
                onWillPop: () async => false,
                child: new CupertinoAlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(btnLabel),
                      isDefaultAction: true,
                      onPressed: _onUpdateNowClicked(),
                    ),
                  ],
                ),
              )
            : WillPopScope(
                onWillPop: () async => false,
                child: new AlertDialog(
                  title: Text(title),
                  content: Text(message),
                  actions: [
                    FlatButton(
                      child: Text(btnLabel),
                      onPressed: _onUpdateNowClicked,
                    ),
                  ],
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
