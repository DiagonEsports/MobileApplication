import 'dart:convert';
import 'package:diagon/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:diagon/screens/home.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:diagon/screens/forgot_password.dart';
import 'package:diagon/screens/send_verification_code.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _username, _password;
  bool _showSpinner = false, _obscureText = true;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      _loginUser();
    }
  }

  void _loginUser() async {
    try {
      setState(() => _showSpinner = true);
      http.Response response = await http.post(
        'https://diagon-server.herokuapp.com/api/users/login',
        body: {
          "username": _username,
          "password": _password,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        _storeUserData(responseData);
        _redirectUser();
      } else {
        setState(() => _showSpinner = false);
        final String errorMsg = responseData['error'];
        _showErrorSnack(errorMsg);
      }
    } catch (e) {
      print(e);
    }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    var token = responseData['token'];
    Map<String, dynamic> user = Jwt.parseJwt(token);

    prefs.setString('user', json.encode(user));
    prefs.setString('token', json.encode(token));

    if (user['isVerified'] == false) {
      Navigator.pushReplacementNamed(context, SendVerificationCode.id);
    }
  }

  void _showErrorSnack(String errorMsg) {
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF101322),
      content: Text(
        errorMsg,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontFamily: 'Google Sans Medium',
          fontSize: 16.0,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception('Error logging in: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Home.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Color(0XFFED0101),
      ),
      child: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0.1,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Welcome.id,
                );
              },
            ),
            title: Text(
              'Account Login',
              style: TextStyle(
                fontFamily: 'Google Sans Medium',
                fontSize: 22.5,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 25.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 150.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (value) => _username = value,
                          validator: (value) =>
                              value.length < 2 ? 'Username too short' : null,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter username',
                            prefixIcon: Icon(
                              FontAwesomeIcons.user,
                              size: 20.0,
                            ),
                          ),
                          onChanged: (value) {
                            _username = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          onSaved: (value) => _password = value,
                          validator: (value) =>
                              value.length < 6 ? 'Password too short' : null,
                          obscureText: _obscureText,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              size: 25.0,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        PrimaryButton(
                          title: 'Login',
                          color: Color(0XFFED0101),
                          borderColor: Color(0XFFED0101),
                          textColor: Colors.white,
                          onPressed: () {
                            _submit();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FlatButton(
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17.0,
                        letterSpacing: 0.5,
                        fontFamily: 'Google Sans Medium',
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPassword.id);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
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
