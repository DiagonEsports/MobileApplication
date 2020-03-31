import 'package:diagon/constants/constants.dart';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/redux/actions.dart';
import 'package:diagon/screens/activity.dart';
import 'package:diagon/screens/home.dart';
import 'package:diagon/screens/login.dart';
import 'package:diagon/screens/news.dart';
import 'package:diagon/screens/password.dart';
import 'package:diagon/screens/wallet.dart';
import 'package:diagon/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:diagon/animations/fade_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  static const String id = 'account';
  final void Function() onInIt;
  Account({this.onInIt});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
        if (state.user != null) {
          return Theme(
            data: Theme.of(context).copyWith(
              accentColor: Color(0XFFED0101),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Account',
                  style: TextStyle(
                    fontFamily: 'Google Sans Medium',
                    fontSize: 20.0,
                  ),
                ),
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        FontAwesomeIcons.bars,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.bell,
                      size: 20.0,
                    ),
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
                              color: Color(0XFFED0101),
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.user,
                            color: Color(0XFFED0101),
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
                        onTap: () async {
                          Navigator.pop(context);
                          StoreProvider.of<AppState>(context)
                              .dispatch(logoutUserAction);
                          Navigator.pushReplacementNamed(context, Welcome.id);
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
                padding: EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(
                              20.0,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            width: MediaQuery.of(context).size.width - 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Color(0xFF1E223B),
                            ),
                            child: Column(
                              children: <Widget>[
                                FadeAnimation(
                                  1.0,
                                  Container(
                                    height: 50.0,
                                    width: 175.0,
                                    child: Image.asset(
                                      'images/logo-horizontal.png',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 35.0,
                                          width: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            color: Color(0XFFED0101),
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.idBadge,
                                            color: Color(0XFFE8E8E8),
                                            size: 22.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          'Username',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Google Sans Medium',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                        Text(
                                          state.user.username,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Google Sans',
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            height: 35.0,
                                            width: 35.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              color: Color(0XFFED0101),
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.envelope,
                                              color: Color(0XFFE8E8E8),
                                              size: 22.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Google Sans Medium',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            state.user.email,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Google Sans',
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 35.0,
                                          width: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            color: Color(0XFFED0101),
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.globeEurope,
                                            color: Color(0XFFE8E8E8),
                                            size: 22.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          'Language (Default)',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Google Sans Medium',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                        Text(
                                          'English (US)',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Google Sans',
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 35.0,
                                          width: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            color: Color(0XFFED0101),
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.checkCircle,
                                            color: Color(0XFFE8E8E8),
                                            size: 22.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          'Verification',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Google Sans Medium',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                        Text(
                                          state.user.isVerified != true
                                              ? 'Not Confirmed'
                                              : "Level 1 - Verified",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Google Sans',
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            margin: EdgeInsets.only(
                              top: 5.0,
                              bottom: 10.0,
                            ),
                            width: MediaQuery.of(context).size.width - 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Color(0xFF1E223B),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 5.0,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Password.id,
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Change Password',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Google Sans Medium',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        FontAwesomeIcons.chevronRight,
                                        color: Color(0XFFE8E8E8),
                                        size: 22.5,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () => launch(
                                      'https://diagon.io/mobile-application-terms-of-use'),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Terms of Service',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Google Sans Medium',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        FontAwesomeIcons.chevronRight,
                                        color: Color(0XFFE8E8E8),
                                        size: 22.5,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () => launch(
                                      'https://diagon.io/mobile-application-privacy-policy'),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Privacy Policy',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Google Sans Medium',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        FontAwesomeIcons.chevronRight,
                                        color: Color(0XFFE8E8E8),
                                        size: 22.5,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(logoutUserAction);
                                    Navigator.pushReplacementNamed(
                                        context, Welcome.id);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Logout',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Google Sans Medium',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        FontAwesomeIcons.chevronRight,
                                        color: Color(0XFFE8E8E8),
                                        size: 22.5,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InkWell(
                                  onTap: () async {
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(logoutUserAction);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Version 1.0.4',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Google Sans',
                                              color: Colors.white
                                                  .withOpacity(0.75),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
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
                                color: Color(0XFFED0101),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Account',
                                style: TextStyle(
                                  color: Color(0XFFED0101),
                                  fontFamily: 'Google Sans Medium',
                                  fontSize: 15.0,
                                ),
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
