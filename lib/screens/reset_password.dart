import 'dart:convert';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/redux/actions.dart';
import 'package:diagon/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'reset_password';
  final void Function() onInit;
  ResetPassword({this.onInit});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _newPassword, _confirmPassword;
  bool _showSpinner = false, _obscureText = true;

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      _resetPassword();
    }
  }

  void _resetPassword() async {
    try {
      setState(() => _showSpinner = true);
      final prefs = await SharedPreferences.getInstance();
      final String storedToken = prefs.getString('token');
      final token = storedToken != null ? json.decode(storedToken) : null;

      http.Response response = await http.post(
        'https://diagon-server.herokuapp.com/api/users/reset-password',
        body: {
          "newPassword": _newPassword,
          "confirmPassword": _confirmPassword,
        },
        headers: {"Authorization": token},
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
        'Password reset successful! Proceed to Login.',
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
      StoreProvider.of<AppState>(context).dispatch(logoutUserAction);
      Navigator.pushReplacementNamed(context, Login.id);
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
                  'Reset Password',
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
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              onSaved: (value) => _newPassword = value,
                              validator: (value) => value.length < 6
                                  ? 'Password too short'
                                  : null,
                              obscureText: _obscureText,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter new password',
                                prefixIcon: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 20.0,
                                ),
                              ),
                              onChanged: (value) {
                                _newPassword = value;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              onSaved: (value) => _confirmPassword = value,
                              validator: (value) => value.length < 6
                                  ? 'Password too short'
                                  : null,
                              obscureText: _obscureText,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Confirm new password',
                                prefixIcon: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 20.0,
                                ),
                              ),
                              onChanged: (value) {
                                _confirmPassword = value;
                              },
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            PrimaryButton(
                              title: 'Reset Password',
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
