import 'dart:convert';
import 'package:diagon/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPin extends StatefulWidget {
  static const String id = 'confirm_pin';

  final String newPin;
  ConfirmPin({this.newPin});

  @override
  _ConfirmPinState createState() => _ConfirmPinState(newPin: newPin);
}

class _ConfirmPinState extends State<ConfirmPin> {
  bool _unFocus = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final String newPin;
  _ConfirmPinState({this.newPin});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Color(0XFFED0101),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.1,
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Confirm your PIN Code',
                    style: TextStyle(
                      fontSize: 22.5,
                      fontFamily: 'Google Sans Medium',
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  PinPut(
                    fieldsCount: 4,
                    autoFocus: false,
                    isTextObscure: true,
                    unFocusWhen: _unFocus,
                    onSubmit: (String confirmPin) =>
                        _onSubmit(confirmPin, newPin),
                    onClear: (String s) => _showSnackBar(
                      'Cleared pin entry',
                      context,
                      Colors.green,
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

  void _onSubmit(String confirmPin, String newPin) async {
    if (newPin == confirmPin) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('pin', json.encode(newPin));

      Navigator.pushReplacementNamed(context, Home.id);
    } else {
      _showSnackBar(
        'New Pin and Confirm Pin do not Match',
        context,
        Colors.red,
      );
    }
  }

  void _showSnackBar(
      String message, BuildContext context, Color backgroundColor) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void setTimeOut() {
    Stream<void>.periodic(Duration(seconds: 5)).listen((r) {
      setState(() {
        _unFocus = !_unFocus;
      });
    });
  }
}
