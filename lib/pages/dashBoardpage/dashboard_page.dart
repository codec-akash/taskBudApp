import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/pages/dashBoardpage/task_list.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var _isInit = true;
  var _isLoading = false;
  var isError = false;
  int len = 0;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<TaskProvider>(context).fetchTasks().then((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              len =
                  Provider.of<TaskProvider>(context, listen: false).tasklength;
              print(len);
            });
          }
        });
      } on HttpException catch (error) {
        print("ONHTTP$error");
        if (mounted) {
          setState(() {
            _isLoading = false;
            isError = true;
          });
        }
      } catch (error) {
        print("ONCATCH$error");
        if (mounted) {
          setState(() {
            _isLoading = false;
            isError = true;
          });
        }
        // _showErrorDialog(errorMessage);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : isError
                ? Center(
                    child: Text("Error Try Again"),
                  )
                : len == 0
                    ? Center(
                        child: Text("No Data"),
                      )
                    : TaskList(),
      ),
    );
  }
}
