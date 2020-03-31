import 'dart:convert';
import 'package:diagon/screens/login.dart';
import 'package:diagon/screens/password_verification_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _email;
  bool _showSpinner = false;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _resendCode();
    }
  }

  void _resendCode() async {
    try {
      setState(() => _showSpinner = true);

      http.Response response = await http.post(
        'https://diagon-server.herokuapp.com/api/users/send-password-verification-code',
        body: {
          "email": _email,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() => _showSpinner = false);
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

  void _showSuccessSnack() {
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF101322),
      content: Text(
        'We have sent a verification code to your email address.',
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
    throw Exception('Error changing password: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, PasswordVerificationCode.id);
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
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Forgot Password',
              style: TextStyle(
                fontFamily: 'Google Sans Medium',
                fontSize: 20.0,
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
                    height: 50.0,
                  ),
                  Text(
                    'We need your email address',
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
                    'We will send a verification code to your email address to enable you change your password.',
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
                          onSaved: (value) => _email = value,
                          validator: (value) => !value.contains('@')
                              ? 'Invalid email address'
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter email address',
                            prefixIcon: Icon(
                              FontAwesomeIcons.solidEnvelope,
                              size: 20.0,
                            ),
                          ),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        PrimaryButton(
                          title: 'Proceed',
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
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        letterSpacing: 0.5,
                        fontFamily: 'Google Sans Medium',
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Login.id);
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
