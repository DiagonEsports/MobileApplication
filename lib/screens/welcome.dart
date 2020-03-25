import 'package:diagon/animations/fade_animation.dart';
import 'package:diagon/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:diagon/screens/login.dart';
import 'package:diagon/widgets/primary_button.dart';
import 'package:flutter/widgets.dart';

class Welcome extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  bool hide = false;

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Color(0XFFED0101),
      ),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(
              right: 30.0,
              left: 30.0,
              top: 20.0,
              bottom: 10.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.85),
                  Colors.black.withOpacity(.65),
                  Colors.black.withOpacity(.75),
                  Colors.black.withOpacity(.75),
                ],
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 175.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.2,
                        Text(
                          'Welcome to the future of eSports.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Google Sans Medium',
                            fontSize: 32.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            height: 1.1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      FadeAnimation(
                        1.4,
                        Text(
                          'Global eSports ecosystem for competitive gaming.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontFamily: 'Google Sans Medium',
                            fontSize: 22.5,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FadeAnimation(
                    1.6,
                    PrimaryButton(
                      title: 'Account Login',
                      borderColor: Color(0XFFED0101),
                      textColor: Color(0xFFFFFFFF),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Login.id,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FadeAnimation(
                    1.8,
                    PrimaryButton(
                      title: 'Create Account',
                      color: Color(0XFFED0101),
                      borderColor: Color(0XFFED0101),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Register.id,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
