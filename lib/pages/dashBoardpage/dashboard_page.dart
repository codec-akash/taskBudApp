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
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<TaskProvider>(context).fetchTasks().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } on HttpException catch (error) {
        print("ONHTTP$error");
        // _showErrorDialog(error.toString());
      } catch (error) {
        print("ONCATCH$error");
        // _showErrorDialog(errorMessage);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TaskList(),
      ),
    );
  }
}
