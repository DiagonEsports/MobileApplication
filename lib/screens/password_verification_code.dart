import 'dart:convert';
import 'package:diagon/screens/forgot_password.dart';
import 'package:diagon/screens/reset_password.dart';
import 'package:diagon/screens/send_verification_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordVerificationCode extends StatefulWidget {
  static const String id = 'password_verification_code';

  @override
  _PasswordVerificationCodeState createState() =>
      _PasswordVerificationCodeState();
}

class _PasswordVerificationCodeState extends State<PasswordVerificationCode> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _code;
  bool _showSpinner = false;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      _verifyPasswordCode();
    }
  }

  void _verifyPasswordCode() async {
    try {
      setState(() => _showSpinner = true);

      http.Response response = await http.post(
        'https://diagon-server.herokuapp.com/api/users/verify-password-code',
        body: {
          "code": _code,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() => _showSpinner = false);

        _storeUserData(responseData);
        _showSuccessSnack();
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

  void _showSuccessSnack() {
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF101322),
      content: Text(
        'Verification successful. Proceed to reset your password.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
          fontFamily: 'Google Sans Medium',
          fontSize: 16.0,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    _formKey.currentState.reset();
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
    throw Exception('Error: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, ResetPassword.id);
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
                    height: 150.0,
                  ),
                  Text(
                    'Confirm Verification Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Google Sans Medium',
                      fontSize: 22.5,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'We sent a verification code to your email address. Enter the code below to enable you change your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Google Sans',
                      fontSize: 17.0,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          onSaved: (value) => _code = value,
                          validator: (value) => value.length < 6
                              ? 'Invalid verification code'
                              : null,
                          keyboardType: TextInputType.number,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter 6-digit code',
                            prefixIcon: Icon(
                              FontAwesomeIcons.lock,
                              size: 20.0,
                            ),
                          ),
                          onChanged: (value) {
                            _code = value;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        PrimaryButton(
                          title: 'Verify Code',
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
                      'Resend Verification Code',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        letterSpacing: 0.5,
                        fontFamily: 'Google Sans Medium',
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPassword.id);
                    },
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
