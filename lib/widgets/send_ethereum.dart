import 'dart:async';
import 'dart:convert';
import 'package:diagon/constants/constants.dart';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/widgets/centered_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendEthereum extends StatefulWidget {
  @override
  _SendEthereumState createState() => _SendEthereumState();
}

class _SendEthereumState extends State<SendEthereum> {
  bool _showSpinner = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController addressController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      _signTransaction();
    }
  }

  void _signTransaction() async {
    try {
      setState(() => _showSpinner = true);
      final prefs = await SharedPreferences.getInstance();
      final String storedToken = prefs.getString('token');
      final token = storedToken != null ? json.decode(storedToken) : null;

      http.Response response = await http.post(
          'https://diagon-server.herokuapp.com/api/transactions/send-ether',
          body: {
            "address": addressController.text,
            "amount": amountController.text,
          },
          headers: {
            "Authorization": token
          });

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
        'Transaction signed successfully',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
          fontFamily: 'Google Sans Medium',
          fontSize: 16.0,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _showErrorSnack(String errorMsg) {
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF101322),
      content: Text(
        errorMsg,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16.0,
          fontFamily: 'Google Sans Medium',
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception('Error logging in: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      return barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print('The user did not allow use of Camera.');
      } else {
        print('Unknown error: $e');
      }
    } on FormatException {
      print(
          'User returned using the "back"-button before scanning anything. Result');
    } catch (e) {
      print('Unknown error: $e');
    }
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
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Send Ethereum',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Google Sans Bold',
                          fontSize: 22.5,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 15.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0XFFE8E8E8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Paste ERC20 Token address you wish to send Diagon Coin or click on the QR Code icon to scan address.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Google Sans Medium',
                            color: Colors.black.withOpacity(0.75),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: addressController,
                              onSaved: (value) =>
                                  addressController.text = value,
                              validator: (value) => value.length < 42
                                  ? 'Invalid ERC20 Address'
                                  : null,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.65),
                                fontFamily: 'Google Sans Medium',
                                fontSize: 18.0,
                              ),
                              decoration: sTextFieldDecoration.copyWith(
                                labelText: 'Enter ERC20 Address',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.65),
                                  fontFamily: 'Google Sans Medium',
                                  fontSize: 18.0,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    scan().then(
                                      (barcode) => setState(
                                        () {
                                          if (barcode.length == 42) {
                                            addressController.text = barcode;
                                          } else {
                                            var mainAddress = barcode
                                                .substring(barcode.length - 42);
                                            addressController.text =
                                                mainAddress;
                                          }
                                        },
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.qrcode,
                                    color: Colors.black.withOpacity(0.70),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                addressController.text = value;
                              },
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            TextFormField(
                              controller: amountController,
                              onSaved: (value) => amountController.text = value,
                              validator: (value) => value.isEmpty
                                  ? 'Amount field is required'
                                  : null,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.65),
                                fontFamily: 'Google Sans Medium',
                                fontSize: 18.0,
                              ),
                              decoration: sTextFieldDecoration.copyWith(
                                labelText: 'Enter DGN Amount',
                                labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.55),
                                  fontFamily: 'Google Sans Medium',
                                  fontSize: 18.0,
                                ),
                              ),
                              onChanged: (value) {
                                amountController.text = value;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            CenteredButton(
                              title: 'Send',
                              color: Color(0XFF1E88E5),
                              borderColor: Color(0XFF1E88E5),
                              icon: FontAwesomeIcons.paperPlane,
                              textColor: Colors.white,
                              onPressed: () async {
                                _submit();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CenteredButton(
                        title: 'Cancel',
                        borderColor: Color(0XFF1E88E5),
                        textColor: Color(0XFF1E88E5),
                        icon: FontAwesomeIcons.timesCircle,
                        iconColor: Color(0XFF1E88E5),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
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
