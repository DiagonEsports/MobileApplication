import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:diagon/screens/confirm_pin.dart';

class NewPin extends StatefulWidget {
  static const String id = 'new_pin';

  @override
  _NewPinState createState() => _NewPinState();
}

class _NewPinState extends State<NewPin> {
  bool _unFocus = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
              horizontal: 30.0,
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
                    'Set a PIN Code',
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
                    autoFocus: true,
                    isTextObscure: true,
                    unFocusWhen: _unFocus,
                    onSubmit: (String newPin) => _onSubmit(newPin),
                    onClear: (String s) => _showSnackBar(
                      'Cleared pin entry',
                      context,
                      Colors.red,
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

  void _onSubmit(String newPin) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ConfirmPin(newPin: newPin);
        },
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context, Color backgroundColor) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              pin,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Google Sans Medium',
              ),
            ),
          )),
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
