import 'package:diagon/redux/actions.dart';
import 'package:diagon/widgets/receive.dart';
import 'package:diagon/constants/constants.dart';
import 'package:diagon/widgets/send.dart';
import 'package:intl/intl.dart';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/screens/account.dart';
import 'package:diagon/screens/activity.dart';
import 'package:diagon/screens/login.dart';
import 'package:diagon/screens/news.dart';
import 'package:diagon/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:diagon/widgets/tournaments.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  static const String id = 'home';
  final void Function() onInit;
  Home({this.onInit});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showSpinner = false;

  void initState() {
    super.initState();
    widget.onInit();
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

        var usdFormatter = NumberFormat.currency(
          symbol: '\$',
          decimalDigits: 2,
        );

        return Theme(
          data: Theme.of(context).copyWith(
            accentColor: Color(0XFFED0101),
          ),
          child: ModalProgressHUD(
            inAsyncCall: false,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(
                  'Hello, ${state.user?.username}',
                  style: TextStyle(
                    fontFamily: 'Google Sans Medium',
                    fontSize: 20.0,
                  ),
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        FontAwesomeIcons.stream,
                        size: 25.0,
                      ),
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
                elevation: 0,
                backgroundColor: Color(0xFF101322),
                brightness: Brightness.dark,
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
                              state.user?.username ?? '',
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
                              state.user?.email ?? '',
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
                              color: Color(0XFFED0101),
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.home,
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
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.wallet,
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
                                  "Contact Support",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Google Sans Bold',
                                  ),
                                ),
                                content: Text(
                                  "Email: help@diagon.io",
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
                        onTap: () {
                          Navigator.pop(context);
                          StoreProvider.of<AppState>(context)
                              .dispatch(logoutUserAction);
                          Navigator.pushReplacementNamed(context, Login.id);
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF101322),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        left: 20,
                                        right: 20,
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Wallet Balance',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22.5,
                                              fontFamily: 'Google Sans',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            state.user != null
                                                ? (dgnFormatter.format(
                                                        state.user.dgnWallet))
                                                    .toString()
                                                : '0.00',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Google Sans Bold',
                                              fontSize: 37.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7.5,
                                          ),
                                          Text(
                                            'DGN',
                                            style: TextStyle(
                                              color: Color(0XFFED0101),
                                              fontFamily: 'Google Sans Bold',
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 20.0,
                                        left: 20.0,
                                        top: 5.0,
                                        bottom: 20.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'USD Balance:',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Google Sans',
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            state.user != null
                                                ? (usdFormatter.format(
                                                        state.user.usdWallet))
                                                    .toString()
                                                : '0.00',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Google Sans Medium',
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 25,
                                ),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0XFF283052),
                                      Color(0XFF283052),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton.icon(
                                      icon: Icon(
                                        FontAwesomeIcons.levelDownAlt,
                                        color: Color(0XFF2ECC71),
                                      ),
                                      elevation: 0.0,
                                      label: Text(
                                        'Receive DGN',
                                        style: TextStyle(
                                          fontFamily: 'Google Sans Medium',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                                    width: 15.0,
                                  ),
                                  Expanded(
                                    child: RaisedButton.icon(
                                      icon: Icon(
                                        FontAwesomeIcons.levelUpAlt,
                                        color: Color(0XFF2ECC71),
                                      ),
                                      elevation: 0.0,
                                      label: Text(
                                        'Send DGN',
                                        style: TextStyle(
                                          fontFamily: 'Google Sans Medium',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Tournaments',
                                style: TextStyle(
                                  fontSize: 22.5,
                                  fontFamily: 'Google Sans Medium',
                                ),
                              ),
                            ),
                            Tournaments(),
                          ],
                        ),
                      ),
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
                                color: Color(0XFFED0101),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: Color(0XFFED0101),
                                  fontFamily: 'Google Sans Medium',
                                  fontSize: 14.0,
                                ),
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
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Wallet',
                                style: bottomNavTextStyle,
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
          ),
        );
      },
    );
  }
}
