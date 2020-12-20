import 'package:Taskbud/Utils/app_media_query.dart';
import 'package:Taskbud/icons/task_bud_icon_icons.dart';
import 'package:flutter/material.dart';

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

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
    } else {
      print("invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
            child: Container(
              height: AppMediaQuery(context).appHeight(90.0),
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
                    onSaved: (newValue) {
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
                    obscureText: showPassword,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return "Password should be greater then 6 letter";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
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
                  Container(
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
