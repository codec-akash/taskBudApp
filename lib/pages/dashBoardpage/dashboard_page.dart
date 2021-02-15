import 'package:Taskbud/Utils/app_media_query.dart';
import 'package:Taskbud/models/category_model.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/pages/dashBoardpage/task_list.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
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
  Map<String, double> category = {};

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
  void didChangeDependencies() async {
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
              len = Provider.of<TaskProvider>(context, listen: false)
                  .inCompletedLength;
              print(len);
            });
          }
        });
        Provider.of<TaskProvider>(context, listen: false).getCategory().then(
            (_) => category =
                Provider.of<TaskProvider>(context, listen: false).categoryData);
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
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            leading: Container(),
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(AppMediaQuery(context).appHeight(18.0)),
              child: category.isNotEmpty
                  ? PieChart(
                      dataMap: category,
                      chartLegendSpacing: 32.0,
                      chartRadius: MediaQuery.of(context).size.width / 2.7,
                      animationDuration: Duration(seconds: 2),
                    )
                  : Container(),
            ),
          )
        ];
      },
      body: Center(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/empty.png"),
                            Text("No Data"),
                          ],
                        ),
                      )
                    : Container(
                        height: AppMediaQuery(context).appHeight(62.0),
                        child: TaskList(),
                      ),
      ),
    );
  }
}
