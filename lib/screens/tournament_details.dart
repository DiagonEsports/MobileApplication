import 'dart:convert';
import 'package:diagon/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:diagon/screens/tournament_success.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:diagon/models/tournament.dart';
import 'package:diagon/animations/fade_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TournamentDetails extends StatefulWidget {
  static const String id = 'tournament_details';

  final Tournament tournament;
  TournamentDetails({this.tournament});

  TournamentDetailsState createState() =>
      TournamentDetailsState(tournament: tournament);
}

class TournamentDetailsState extends State<TournamentDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final Tournament tournament;
  TournamentDetailsState({this.tournament});

  bool _showSpinner = false;

  void joinTournament() async {
    try {
      setState(() => _showSpinner = true);
      final prefs = await SharedPreferences.getInstance();
      final String storedToken = prefs.getString('token');
      final token = storedToken != null ? json.decode(storedToken) : null;

      http.Response response = await http.post(
          'https://diagon-server.herokuapp.com/api/tournaments/join',
          body: {"tournamentId": tournament.id},
          headers: {"Authorization": token});

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() => _showSpinner = false);
        if (responseData['indicator'] == 0) {
          _showErrorSnack(responseData['message']);
        } else if (responseData['indicator'] == 1) {
          _showErrorSnack(responseData['message']);
        } else if (responseData['indicator'] == 2) {
          _showSuccessSnack(responseData['message']);
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return TournamentSuccess(responseData: responseData);
                },
              ),
            );
          });
        } else if (responseData['indicator'] == 3) {
          _showErrorSnack(responseData['message']);
        } else {
          _showErrorSnack('Something went wrong. Try again after sometime.');
        }
      } else {
        setState(() => _showSpinner = false);
        _showErrorSnack(responseData['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  void _showSuccessSnack(String msg) {
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF101322),
      content: Text(
        msg,
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
          fontFamily: 'Google Sans Medium',
          fontSize: 16.0,
        ),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    throw Exception('Error registering: $errorMsg');
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = tournament.pictureUrl;
    final int takenSeat = tournament.takenSeats;

    var dgnFormatter = NumberFormat.currency(
      name: '',
      decimalDigits: 2,
    );

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
              backgroundColor: Colors.black,
              body: Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        expandedHeight: 450.0,
                        backgroundColor: Color(0xFF101322),
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(pictureUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black,
                                    Colors.black.withOpacity(.3),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  20.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FadeAnimation(
                                      1,
                                      Text(
                                        tournament.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Google Sans Bold',
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        FadeAnimation(
                                          1.2,
                                          Text(
                                            "Platform:",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontFamily: 'Google Sans Medium',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        FadeAnimation(
                                          1.2,
                                          Text(
                                            tournament.platform,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(.8),
                                              fontSize: 25.0,
                                              fontFamily: 'Google Sans Medium',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0,
                                bottom: 20.0,
                                right: 20.0,
                                left: 20.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  FadeAnimation(
                                    1.4,
                                    Text(
                                      "Price Pool",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Google Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  FadeAnimation(
                                    1.4,
                                    Text(
                                      (dgnFormatter
                                                  .format(tournament.pricePool))
                                              .toString() +
                                          ' DGN',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Google Sans Medium',
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  FadeAnimation(
                                    1.6,
                                    Text(
                                      "Entry Fee",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Google Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  FadeAnimation(
                                    1.6,
                                    Text(
                                      tournament.entryFee == 0
                                          ? 'FREE'
                                          : '\$' +
                                              tournament.entryFee.toString() +
                                              '.00',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Google Sans Medium',
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FadeAnimation(
                                    1.6,
                                    Text(
                                      "Seats",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Google Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  FadeAnimation(
                                    1.6,
                                    Text(
                                      tournament.availableSeats.toString() +
                                          ' Available' +
                                          ' ($takenSeat Taken)',
                                      style: TextStyle(
                                        fontFamily: 'Google Sans',
                                        fontSize: 18.0,
                                        color: Colors.white.withOpacity(.8),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  FadeAnimation(
                                    1.6,
                                    Text(
                                      "Tournament Details and Rules",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Google Sans',
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  FadeAnimation(
                                    1.6,
                                    Text(
                                      tournament.description,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(.8),
                                        fontSize: 16,
                                        fontFamily: 'Google Sans',
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 120.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned.fill(
                    bottom: 50,
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FadeAnimation(
                          2,
                          InkWell(
                            onTap: () {
                              joinTournament();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0XFFED0101)),
                              child: Align(
                                child: Text(
                                  'Join Tournament',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Google Sans Medium',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
