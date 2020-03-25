import 'package:diagon/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Payment extends StatelessWidget {
  static const String id = 'payment';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Color(0XFFED0101),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          centerTitle: true,
          title: Text(
            'Upcoming Tournament',
            style: TextStyle(
              fontFamily: 'Google Sans Medium',
              fontSize: 22.5,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 0, right: 24.0, left: 24.0, bottom: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 175.0,
                child: Icon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.white,
                  size: 120,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: <Widget>[
                  Text('Welcome'),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text('Welcome'),
                  SizedBox(
                    height: 40.0,
                  ),
                  PrimaryButton(
                    title: 'Done',
                    color: Color(0XFFED0101),
                    borderColor: Color(0XFFED0101),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, Home.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
