import 'dart:convert';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/screens/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendVerificationCode extends StatefulWidget {
  static const String id = 'resend_verification_code';
  final void Function() onInit;
  SendVerificationCode({this.onInit});

  @override
  _SendVerificationCodeState createState() => _SendVerificationCodeState();
}

class _SendVerificationCodeState extends State<SendVerificationCode> {
  void initState() {
    super.initState();
    widget.onInit();
  }

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
        'https://diagon-server.herokuapp.com/api/users/send-verification-code',
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
      Navigator.pushReplacementNamed(context, VerificationCode.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
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
                        'Verify Email Address',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Google Sans Medium',
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'We will send a verification code to your email address to verify your account.',
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
                              initialValue: state.user.email,
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
                              title: 'Send Code',
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
