import 'package:Taskbud/Utils/theme.dart';
import 'package:Taskbud/pages/dashBoardpage/dashboard_page.dart';
import 'package:Taskbud/pages/historyPage/history_page.dart';
import 'package:Taskbud/pages/taskPage/add_task.dart';
import 'package:Taskbud/providers/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    DashBoardPage(),
    AddTaskPage(),
    HistoryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () async {
              Navigator.of(context).pop();
              await Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("TaskBud"),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Text("Dark Theme"),
              trailing: Switch(
                value: theme.darkTheme,
                onChanged: (value) {
                  theme.toggleTheme();
                },
              ),
            ),
            ListTile(
              leading: Text("Logout"),
              onTap: () {
                Navigator.of(context).pop();
                _showDialog("Are you Sure you want to Logout");
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: ClipRRect(
          // clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 20,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                label: 'Add Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                label: 'History',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).secondaryHeaderColor,
            selectedFontSize: 10,
            selectedLabelStyle:
                TextStyle(color: Theme.of(context).secondaryHeaderColor),
            unselectedFontSize: 10,
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
