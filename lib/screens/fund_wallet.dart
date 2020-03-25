import 'dart:convert';
import 'package:diagon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:diagon/animations/fade_animation.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FundWallet extends StatefulWidget {
  static const String id = 'fund_wallet';
  @override
  _FundWalletState createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  int amount;
  var publicKey = 'pk_test_4ad25b495e8eea1c34b17fa839ad6aa71106b4fd';
  var moneyMask = new MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      _makePayment();
    }
  }

  void _makePayment() async {
    final prefs = await SharedPreferences.getInstance();
    final String storedUser = prefs.getString('user');
    final User user = User.fromJson(json.decode(storedUser));

    Charge charge = Charge();
    charge.amount = amount * 100;
    charge.currency = 'USD';
    charge.reference = _getReference();
    charge.email = user.email;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    print(response);
  }

  String _getReference() {
    return randomAlpha(10);
  }

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: publicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Fund Wallet',
          style: TextStyle(
            fontFamily: 'Google Sans Medium',
            fontSize: 22.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 0, right: 24.0, left: 24.0, bottom: 50.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 15.0,
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          width: MediaQuery.of(context).size.width - 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Color(0xFF1E223B),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1.0,
                    Container(
                      child: Icon(
                        FontAwesomeIcons.wallet,
                        color: Color(0XFFE8E8E8),
                        size: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Text(
                    'Fund your USD Wallet to buy DGN',
                    style: TextStyle(
                      fontFamily: 'Google Sans Medium',
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (value) {
                            amount = moneyMask.numberValue.toInt();
                          },
                          controller: moneyMask,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter amount in USD',
                            prefixIcon: Icon(
                              FontAwesomeIcons.dollarSign,
                              size: 20.0,
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'You can only fund a minimum of \$10.00',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Google Sans',
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        PrimaryButton(
                          title: 'Proceed',
                          color: Color(0XFFED0101),
                          borderColor: Color(0XFFED0101),
                          textColor: Colors.white,
                          onPressed: () async {
                            _submit();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 75.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
