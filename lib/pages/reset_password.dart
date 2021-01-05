import 'package:Taskbud/Utils/app_media_query.dart';
import 'package:Taskbud/Utils/global.dart';
import 'package:Taskbud/icons/task_bud_icon_icons.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = 'resetPassword';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  bool showPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;
  String _previousPassword;
  String _confirmPassword;
  String _password;

  Future<void> _trySubmit() async {
    var validate = _formKey.currentState.validate();
    print(_confirmPassword);
    print(_password);
    if (validate) {
      try {
        await Provider.of<Auth>(context, listen: false)
            .resetPassword(_previousPassword, _password);
        _scaffold.currentState.showSnackBar(SnackBar(
          content: Text(
            "Password Updated",
            style: scaffoldHeader,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ));
      } on HttpException catch (error) {
        _scaffold.currentState.showSnackBar(SnackBar(
          content: Text(
            error.toString(),
            style: scaffoldHeader,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ));
      } catch (e) {
        _scaffold.currentState.showSnackBar(SnackBar(
          content: Text(
            e.toString(),
            style: scaffoldHeader,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Reset Password'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    "images/reset_pasword.png",
                    fit: BoxFit.contain,
                    height: AppMediaQuery(context).appHeight(28.0),
                    alignment: Alignment.bottomRight,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  children: [
                    TextFormField(
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(TaskBudIcon.password),
                        suffixIcon: IconButton(
                          icon: showPassword
                              ? Icon(TaskBudIcon.eye_open)
                              : Icon(TaskBudIcon.eye_off),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: textFieldBorderSide,
                          borderRadius: textFieldBorderRadius,
                        ),
                        labelText: 'Previous-Password',
                        labelStyle: hintStyle,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter previous password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _previousPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: showNewPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(TaskBudIcon.password),
                        suffixIcon: IconButton(
                          icon: showNewPassword
                              ? Icon(TaskBudIcon.eye_open)
                              : Icon(TaskBudIcon.eye_off),
                          onPressed: () {
                            setState(() {
                              showNewPassword = !showNewPassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: textFieldBorderSide,
                          borderRadius: textFieldBorderRadius,
                        ),
                        labelText: 'New-Password',
                        labelStyle: hintStyle,
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 8) {
                          return "password should be greater then 7 letters";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _confirmPassword = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: showConfirmPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(TaskBudIcon.password),
                        suffixIcon: IconButton(
                          icon: showConfirmPassword
                              ? Icon(TaskBudIcon.eye_open)
                              : Icon(TaskBudIcon.eye_off),
                          onPressed: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: textFieldBorderSide,
                          borderRadius: textFieldBorderRadius,
                        ),
                        labelText: 'New-Password',
                        labelStyle: hintStyle,
                      ),
                      validator: (value) {
                        if (value.isEmpty ||
                            value.length < 8 ||
                            _confirmPassword != _password) {
                          return "New Password does not matched";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          "Add Task",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: _trySubmit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
