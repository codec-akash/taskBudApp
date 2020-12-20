import 'package:Taskbud/Utils/app_media_query.dart';
import 'package:Taskbud/icons/task_bud_icon_icons.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/global.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool showPassword = false;

  String _userEmail;
  String _userPassword;

  bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

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

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      try {
        print("reached");
        print(_userPassword);
        await Provider.of<Auth>(context, listen: false)
            .login(_userEmail, _userPassword);
      } on HttpException catch (error) {
        print(error);
        _showErrorDialog(error.toString());
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      print("invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomCenter,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 14.0),
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "images/login.png",
                      fit: BoxFit.contain,
                      height: AppMediaQuery(context).appHeight(35.0),
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                  Text(
                    "Login",
                    style: mainHeader,
                  ),
                  SizedBox(
                    height: AppMediaQuery(context).appHeight(02),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.snooze),
                      border: OutlineInputBorder(
                        borderSide: textFieldBorderSide,
                        borderRadius: textFieldBorderRadius,
                      ),
                      labelText: 'Email-id',
                      labelStyle: hintStyle,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!validateEmail(value)) {
                        return "Please Enter a valid Email!";
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      _userEmail = newValue;
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.snooze),
                      border: OutlineInputBorder(
                        borderSide: textFieldBorderSide,
                        borderRadius: textFieldBorderRadius,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.panorama_fish_eye),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      labelText: 'Password',
                      labelStyle: hintStyle,
                    ),
                    obscureText: !showPassword,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return "Password should be greater then 6 letter";
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      _userPassword = newValue;
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(child: Text("forgot-password")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? Center(child: Text("Loggin IN"))
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.infinity,
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            onPressed: _trySubmit,
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.white,
                    height: 28,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        "Don't have Acc, Sign-Up!",
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
