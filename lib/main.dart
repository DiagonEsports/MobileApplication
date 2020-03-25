import 'package:diagon/redux/actions.dart';
import 'package:diagon/screens/account.dart';
import 'package:diagon/screens/activity.dart';
import 'package:diagon/screens/forgot_password.dart';
import 'package:diagon/screens/password.dart';
import 'package:diagon/screens/password_verification_code.dart';
import 'package:diagon/screens/reset_password.dart';
import 'package:diagon/screens/send_verification_code.dart';
import 'package:diagon/screens/verification_code.dart';
import 'package:diagon/screens/wallet.dart';
import 'screens/fund_wallet.dart';
import 'package:diagon/redux/reducers.dart';
import 'package:diagon/screens/home.dart';
import 'package:diagon/screens/login.dart';
import 'package:diagon/screens/register.dart';
import 'package:diagon/screens/news.dart';
import 'package:diagon/screens/tournament_details.dart';
import 'package:diagon/screens/tournament_success.dart';
import 'package:diagon/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'models/app_state.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF101322),
          scaffoldBackgroundColor: Color(0xFF101322),
        ),
        initialRoute: Welcome.id,
        routes: {
          Welcome.id: (context) => Welcome(),
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
          Home.id: (context) => Home(
                onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getTournamentsAction);
                },
              ),
          TournamentDetails.id: (context) => TournamentDetails(),
          TournamentSuccess.id: (context) => TournamentSuccess(),
          FundWallet.id: (context) => FundWallet(),
          News.id: (context) => News(
                onInIt: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(getAllNewsAction);
                },
              ),
          Activity.id: (context) => Activity(
                onInIt: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getTransactionsAction);
                },
              ),
          Wallet.id: (context) => Wallet(
                onInIt: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                },
              ),
          Account.id: (context) => Account(
                onInIt: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                },
              ),
          Password.id: (context) => Password(
                onInIt: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                },
              ),
          VerificationCode.id: (context) => VerificationCode(),
          SendVerificationCode.id: (context) => SendVerificationCode(
                onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                },
              ),
          ForgotPassword.id: (context) => ForgotPassword(),
          PasswordVerificationCode.id: (context) => PasswordVerificationCode(),
          ResetPassword.id: (context) => ResetPassword(
                onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                },
              ),
        },
      ),
    );
  }
}
