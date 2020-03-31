import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:diagon/screens/send_verification_code.dart';
import 'package:diagon/screens/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:url_launcher/url_launcher.dart';

class Register extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _username, _email, _password, _dob;
  bool _showSpinner = false, _obscureText = true;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _registerUser();
    }
  }

  void _registerUser() async {
    try {
      setState(() => _showSpinner = true);

      http.Response response = await http.post(
        'https://diagon-server.herokuapp.com/api/users/register',
        body: {
          "username": _username,
          "email": _email,
          "password": _password,
          "dob": _dob,
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
        'Account Created Successfully!',
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
    throw Exception('Error registering user: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, VerificationCode.id);
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
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Create Account',
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
                    height: 10.0,
                  ),
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 125.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          onSaved: (value) => _username = value,
                          validator: (value) =>
                              value.length < 3 ? 'Username is too short' : null,
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
                          onSaved: (value) => _email = value,
                          validator: (value) => !value.contains('@')
                              ? 'Invalid email address'
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email',
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
                              size: 20.0,
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
                          height: 20.0,
                        ),
                        DateTimeField(
                          format: format,
                          validator: (value) =>
                              value == null ? 'Invalid Date of Birth' : null,
                          onSaved: (value) => _dob = value.toString(),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Date of Birth',
                            prefixIcon: Icon(
                              FontAwesomeIcons.calendarAlt,
                              size: 20.0,
                            ),
                          ),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime(1920),
                              initialDate: currentValue ?? DateTime(2002),
                              lastDate: DateTime(2005),
                            );
                          },
                          onChanged: (value) {
                            _dob = value.toString();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'By Creating an account, you are indicating that you have read and acknowledged the',
                              ),
                              TextSpan(
                                text: ' Terms of Service',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Google Sans Medium',
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://diagon.io/mobile-application-terms-of-use');
                                  },
                              ),
                              TextSpan(
                                text: ' and',
                              ),
                              TextSpan(
                                text: ' Privacy Policy',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'Google Sans Medium',
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://diagon.io/mobile-application-privacy-policy');
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        PrimaryButton(
                          title: 'Create Account',
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
