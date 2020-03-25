import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:diagon/screens/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:diagon/animations/fade_animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TournamentSuccess extends StatelessWidget {
  static const String id = 'tournament_success';

  final Map<String, dynamic> responseData;
  TournamentSuccess({this.responseData});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Color(0XFFED0101),
      ),
      child: Scaffold(
        backgroundColor: Color(0XFF0b0d1a),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            right: 20.0,
            left: 20.0,
            bottom: 20.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                FadeAnimation(
                  1.0,
                  Container(
                    child: Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FadeAnimation(
                  1.1,
                  Container(
                    child: Text(
                      'Success!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Google Sans Medium',
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 15.0,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  width: MediaQuery.of(context).size.width - 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xFF1a1e36),
                  ),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.2,
                        Text(
                          'You have successfully joined the ' +
                              responseData['tournament']['title'] +
                              ' tournament',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.5,
                            fontFamily: 'Google Sans Medium',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      FadeAnimation(
                        1.3,
                        Text(
                          'Tournament Date & Start Time',
                          style: TextStyle(
                            fontFamily: 'Google Sans Bold',
                            fontSize: 22.5,
                            color: Color(0XFFED0101),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      FadeAnimation(
                        1.4,
                        Text(
                          DateFormat.yMMMMd().add_jms().format(
                                    DateTime.parse(responseData['tournament']
                                        ['startTime']),
                                  ) +
                              ' (GMT)',
                          style: TextStyle(
                            fontFamily: 'Google Sans Medium',
                            fontSize: 18.0,
                            color: Color(0XFFE0E0E0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FadeAnimation(
                        1.5,
                        Text(
                          'Join Discord Server',
                          style: TextStyle(
                            fontFamily: 'Google Sans Bold',
                            fontSize: 22.5,
                            color: Color(0XFFED0101),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      FadeAnimation(
                        1.6,
                        InkWell(
                          onTap: () =>
                              launch(responseData['tournament']['discordUrl']),
                          child: Text(
                            responseData['tournament']['discordUrl'],
                            style: TextStyle(
                              fontFamily: 'Google Sans Medium',
                              fontSize: 18.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      FadeAnimation(
                        1.7,
                        Text(
                          'NB:  You must join the tournament discord server for a check in at most 6 hours before the tournament begins.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17.0,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      FadeAnimation(
                        1.8,
                        PrimaryButton(
                          title: 'Back Home',
                          color: Color(0XFFED0101),
                          borderColor: Color(0XFFED0101),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, Home.id);
                          },
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
    );
  }
}
