import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:diagon/models/news.dart';
import 'package:diagon/screens/news_details.dart';
import 'package:diagon/constants/constants.dart';

class NewsItem extends StatelessWidget {
  final News news;

  NewsItem({this.news});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = news.pictureUrl;

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return NewsDetails(news: news);
          },
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 50.0,
        padding: EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 12.5,
        ),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFF1a1e36),
        ),
        child: Column(
          children: <Widget>[
            buildPicture(context, imageUrl),
            buildTitle(news.title),
            buildText(news.text),
            buildFooterBox(news.date),
          ],
        ),
      ),
    );
  }

  Widget buildPicture(BuildContext context, String picture) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        picture,
        fit: BoxFit.fitWidth,
        width: MediaQuery.of(context).size.width - 50.0,
        height: 175.0,
        loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
          if (progress == null) return child;
          return Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget buildTitle(String name) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 15.0,
        left: 15.0,
        bottom: 5.0,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'How DPC changes will really affect Dota 2 esports',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Google Sans Medium',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5.0,
        right: 15.0,
        left: 15.0,
        bottom: 10.0,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Google Sans',
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }

  Widget buildFooterBox(DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0, left: 16.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            DateFormat.yMMMMd().format(date),
            style: TextStyle(
              fontFamily: 'Google Sans',
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: mainColor,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
