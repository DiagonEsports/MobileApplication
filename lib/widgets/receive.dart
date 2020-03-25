import 'package:diagon/models/app_state.dart';
import 'package:diagon/widgets/centered_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Receive extends StatefulWidget {
  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Scan to Receive',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Google Sans Bold',
                      fontSize: 25.0,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Center(
                    child: QrImage(
                      data: 'ethereum:' + (state.user.defaultERC20).toString(),
                      version: QrVersions.auto,
                      size: 175.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Address',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Google Sans Bold',
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Text(
                      state.user.defaultERC20,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Google Sans',
                        fontSize: 14.0,
                        color: Colors.black.withOpacity(0.85),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CenteredButton(
                    title: 'Copy Address',
                    color: Color(0XFF1E88E5),
                    borderColor: Color(0XFF1E88E5),
                    icon: FontAwesomeIcons.copy,
                    textColor: Colors.white,
                    onPressed: () {
                      ClipboardManager.copyToClipBoard(state.user.defaultERC20)
                          .then((result) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.black.withOpacity(0.75),
                          content: Text(
                            'Copied to Clipboard',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18.0,
                              fontFamily: 'Google Sans Medium',
                            ),
                          ),
                          action: SnackBarAction(
                            label: 'Undo',
                            textColor: Colors.white.withOpacity(0.8),
                            onPressed: () {},
                          ),
                        );
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      });
                    },
                  ),
                  SizedBox(
                    height: 125.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
