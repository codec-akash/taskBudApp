import 'package:Taskbud/Utils/app_media_query.dart';
import 'package:Taskbud/Utils/global.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = 'signup-page';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool isLoading = false;

  String _userEmail;
  String _userPassword;
  String _phoneNumber;
  String _name;

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
        await Provider.of<Auth>(context, listen: false).register(
          email: _userEmail,
          password: _userPassword,
          name: _name,
          phoneNumber: _phoneNumber,
        );
        Navigator.of(context).pop();
      } on HttpException catch (error) {
        print(error);
        _showErrorDialog(error.toString());
      } catch (error) {
        print(error);
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 14.0),
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Text(
                    "<<- Login",
                    style: secondaryHeader,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "SignUp",
                          style: mainHeader,
                        ),
                      ],
                    ),
                    Image.asset(
                      'images/signup.png',
                      fit: BoxFit.contain,
                      height: AppMediaQuery(context).appHeight(25.0),
                      width: AppMediaQuery(context).appWidth(45.0),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.snooze),
                          border: OutlineInputBorder(
                            borderSide: textFieldBorderSide,
                            borderRadius: textFieldBorderRadius,
                          ),
                          labelText: 'Name',
                          labelStyle: hintStyle,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter a valid Name!";
                          }
                          return null;
                        },
                        onChanged: (newValue) {
                          _name = newValue;
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
                          labelText: '10 digit Phone-Number',
                          labelStyle: hintStyle,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty ||
                              value.length < 10 ||
                              value.length > 10) {
                            return "Please Enter a valid phone-number!";
                          }
                          return null;
                        },
                        onChanged: (newValue) {
                          _phoneNumber = newValue;
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
                        height: 24,
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
                            "Register",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: _trySubmit,
                        ),
                      ),
                    ],
                  ),
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
                      "Have an Accont! Login",
                      style: secondaryHeader,
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
