import 'package:diagon/redux/actions.dart';
import 'package:diagon/widgets/receive.dart';
import 'package:diagon/widgets/send.dart';
import 'package:diagon/widgets/send_ethereum.dart';
import 'package:intl/intl.dart';
import 'package:diagon/constants/constants.dart';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/screens/account.dart';
import 'package:diagon/screens/activity.dart';
import 'package:diagon/screens/home.dart';
import 'package:diagon/screens/login.dart';
import 'package:diagon/screens/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wallet extends StatefulWidget {
  static const String id = 'wallet';
  final void Function() onInIt;
  Wallet({this.onInIt});

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    super.initState();
    widget.onInIt();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        var dgnFormatter = NumberFormat.currency(
          name: '',
          decimalDigits: 2,
        );

        var ethFormatter = NumberFormat.currency(
          name: '',
          decimalDigits: 6,
        );

        var usdFormatter = NumberFormat.currency(
          name: '',
          decimalDigits: 2,
        );

        if (state.user != null) {
          return Theme(
            data: Theme.of(context).copyWith(
              accentColor: Color(0XFFED0101),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Wallets',
                  style: TextStyle(
                    fontFamily: 'Google Sans Medium',
                    fontSize: 20.0,
                  ),
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(FontAwesomeIcons.stream),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.bell),
                    onPressed: () {},
                  ),
                ],
                textTheme: TextTheme(
                  title: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              drawer: Drawer(
                child: Container(
                  color: Color(0xFF101322),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        color: Color(0xFF1a1e36),
                        padding: EdgeInsets.only(
                          right: 100.0,
                          left: 25.0,
                          top: 25.0,
                          bottom: 25.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 160.0,
                              height: 40.0,
                              child: Image.asset(
                                'images/logo-horizontal.png',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              state.user?.username,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Google Sans Bold',
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              state.user?.email,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Google Sans Medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            this.context,
                            Home.id,
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Google Sans Medium',
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.home,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            this.context,
                            Activity.id,
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Activity',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Google Sans Medium',
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.listAlt,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            this.context,
                            Wallet.id,
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Wallet',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Google Sans Medium',
                              color: Color(0XFFED0101),
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.wallet,
                            color: Color(0XFFED0101),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            this.context,
                            News.id,
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Esport News',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Google Sans Medium',
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.newspaper,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            this.context,
                            Account.id,
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Account',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Google Sans Medium',
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.user,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Reach Support @",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Google Sans Bold',
                                  ),
                                ),
                                content: Text(
                                  "help@diagon.io",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Google Sans',
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Support',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Google Sans Medium',
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.lifeRing,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          StoreProvider.of<AppState>(context)
                              .dispatch(logoutUserAction);
                        },
                        child: ListTile(
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: 'Google Sans Medium',
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.signOutAlt,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width - 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF1E223B),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'DGN Balance',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Google Sans Bold',
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  (dgnFormatter.format(state.user.dgnWallet))
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Google Sans Bold',
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'DGN',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Google Sans Bold',
                                    color: Color(0XFFED0101),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.levelDownAlt,
                                      color: Color(0XFF2ECC71),
                                      size: 15.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    label: Text(
                                      'Receive DGN',
                                      style: TextStyle(
                                        fontFamily: 'Google Sans Medium',
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Receive(),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 7.5,
                                ),
                                Expanded(
                                  child: RaisedButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.levelUpAlt,
                                      color: Color(0XFF2ECC71),
                                      size: 15.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    label: Text(
                                      'Send DGN',
                                      style: TextStyle(
                                        fontFamily: 'Google Sans Medium',
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Send(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width - 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF1E223B),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'ETH Balance',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Google Sans Bold',
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  (ethFormatter.format(state.user.ethWallet))
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Google Sans Bold',
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'ETH',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Google Sans Bold',
                                    color: Color(0XFFED0101),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.levelDownAlt,
                                      color: Color(0XFF2ECC71),
                                      size: 15.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    label: Text(
                                      'Receive ETH',
                                      style: TextStyle(
                                        fontFamily: 'Google Sans Medium',
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Receive(),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 7.5,
                                ),
                                Expanded(
                                  child: RaisedButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.levelUpAlt,
                                      color: Color(0XFF2ECC71),
                                      size: 15.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    label: Text(
                                      'Send ETH',
                                      style: TextStyle(
                                        fontFamily: 'Google Sans Medium',
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => SendEthereum(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width - 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF1E223B),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'USD Balance',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Google Sans Bold',
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  (usdFormatter.format(state.user.usdWallet))
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Google Sans Bold',
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'USD',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Google Sans Bold',
                                    color: Color(0XFFED0101),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.levelDownAlt,
                                      color: Color(0XFF2ECC71),
                                      size: 15.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    label: Text(
                                      'Fund Wallet',
                                      style: TextStyle(
                                        fontFamily: 'Google Sans Medium',
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Currently not Available",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontFamily: 'Google Sans Bold',
                                              ),
                                            ),
                                            content: Text(
                                              "You will be notified by email when this feature is available.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: 'Google Sans',
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 7.5,
                                ),
                                Expanded(
                                  child: RaisedButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.levelUpAlt,
                                      color: Color(0XFF2ECC71),
                                      size: 15.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    label: Text(
                                      'Swap USD',
                                      style: TextStyle(
                                        fontFamily: 'Google Sans Medium',
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Insufficient Funds",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Google Sans Bold',
                                              ),
                                            ),
                                            content: Text(
                                              "Your USD Balance is currently too low for a swap.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontFamily: 'Google Sans',
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                color: Color(0xFF1a1e36),
                child: Container(
                  height: 60.0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              this.context,
                              Home.id,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.home,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Home',
                                style: bottomNavTextStyle,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              this.context,
                              Wallet.id,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.wallet,
                                color: Color(0XFFED0101),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Wallet',
                                style: TextStyle(
                                  color: Color(0XFFED0101),
                                  fontFamily: 'Google Sans Medium',
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              this.context,
                              Activity.id,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.listAlt,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Activity',
                                style: bottomNavTextStyle,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              this.context,
                              News.id,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.newspaper,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'News',
                                style: bottomNavTextStyle,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              this.context,
                              Account.id,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Account',
                                style: bottomNavTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Login();
        }
      },
    );
  }
}
