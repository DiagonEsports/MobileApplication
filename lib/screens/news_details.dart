import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:diagon/models/news.dart';
import 'package:diagon/animations/fade_animation.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class NewsDetails extends StatefulWidget {
  static const String id = 'news_details';

  final News news;
  NewsDetails({this.news});

  NewsDetailsState createState() => NewsDetailsState(news: news);
}

class NewsDetailsState extends State<NewsDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final News news;

  NewsDetailsState({this.news});

  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = news.pictureUrl;

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
                                    news.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Google Sans Bold',
                                      fontSize: 26.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FadeAnimation(
                                  1.2,
                                  Text(
                                    DateFormat.yMMMMd().format(
                                      news.date,
                                    ),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.9),
                                      fontSize: 18,
                                      fontFamily: 'Google Sans Medium',
                                    ),
                                  ),
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
                              FadeAnimation(
                                1.6,
                                Text(
                                  news.text,
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
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0XFFED0101)),
                          child: Align(
                            child: Text(
                              'Back to Feed',
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
  }
}
