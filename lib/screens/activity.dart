import 'package:diagon/constants/constants.dart';
import 'package:diagon/models/app_state.dart';
import 'package:diagon/redux/actions.dart';
import 'package:diagon/screens/account.dart';
import 'package:diagon/screens/home.dart';
import 'package:diagon/screens/login.dart';
import 'package:diagon/screens/news.dart';
import 'package:diagon/screens/wallet.dart';
import 'package:diagon/widgets/activity_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Activity extends StatefulWidget {
  static const String id = 'activity';
  final void Function() onInIt;
  Activity({this.onInIt});

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(
                  'Activity',
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
                              color: Color(0XFFED0101),
                            ),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.listAlt,
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
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: StoreConnector<AppState, AppState>(
                    converter: (store) => store.state,
                    builder: (_, state) {
                      if (state.transactions.length == 0) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 15.0,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 15.0,
                          ),
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF1E223B),
                          ),
                          child: Text(
                            'You currently have no Transaction.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontFamily: 'Google Sans',
                              fontSize: 17.0,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.all(2.0),
                          itemCount: state.transactions.length ?? 0,
                          itemBuilder: (BuildContext context, int i) =>
                              ActivityItem(
                            transaction: state.transactions[i],
                          ),
                        );
                      }
                    },
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
                                color: Color(0XFFED0101),
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Text(
                                'Activity',
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
