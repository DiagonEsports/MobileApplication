import 'dart:async';
import 'dart:convert';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/redux/actions.dart';
import 'package:diagon/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:diagon/screens/home.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class Pin extends StatefulWidget {
  static const String id = 'pin';

  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  bool _unFocus = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    await _getListOfBiometricTypes();
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    if (listOfBiometrics.length != 0) {
      await _authenticateUser();
    }

    return;
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Authentication required to unlock your application.",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, Home.id);
    }
  }

  @override
  void initState() {
    _isBiometricAvailable();
    super.initState();
  }

  void _onSubmit(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    final String storedPin = prefs.getString('pin');
    final checkPin = storedPin != null ? json.decode(storedPin) : null;

    if (pin == checkPin) {
      Navigator.pushReplacementNamed(context, Home.id);
    } else {
      _showSnackBar(
        'Invalid Pin Code',
        context,
        Colors.red,
      );
    }
  }

  void _showSnackBar(
      String message, BuildContext context, Color backgroundColor) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Google Sans Medium',
            ),
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
                horizontal: 5.0,
                vertical: 20.0,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Enter your PIN Code',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Google Sans Medium',
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  PinPut(
                    fieldsCount: 4,
                    autoFocus: true,
                    isTextObscure: true,
                    unFocusWhen: _unFocus,
                    onSubmit: (String pin) => _onSubmit(pin),
                    onClear: (String s) =>
                        _showSnackBar('Cleared pin entry', context, Colors.red),
                  ),
                  FlatButton(
                    child: Text(
                      'Forgot Code',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        letterSpacing: 0.5,
                        fontFamily: 'Google Sans Medium',
                      ),
                    ),
                    onPressed: () {
                      StoreProvider.of<AppState>(context)
                          .dispatch(logoutUserAction);
                      Navigator.pushReplacementNamed(context, Welcome.id);
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
