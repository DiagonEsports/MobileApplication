import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:diagon/models/tournament.dart';
import 'package:diagon/screens/tournament_details.dart';
import 'package:diagon/constants/constants.dart';

class TournamentItem extends StatelessWidget {
  final Tournament tournament;

  TournamentItem({this.tournament});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = tournament.pictureUrl;

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return TournamentDetails(tournament: tournament);
          },
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 0,
        ),
        margin: EdgeInsets.only(
          top: 6.0,
          right: 5.0,
          left: 5.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0XFF171B30),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              buildPicture(imageUrl),
              buildTitle(tournament.title),
              buildPricePool(tournament.pricePool.toDouble()),
              buildSeat(tournament.availableSeats, tournament.takenSeats),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPicture(String picture) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 7.5,
        right: 7.5,
        left: 7.5,
      ),
      child: Hero(
        tag: picture,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            picture,
            fit: BoxFit.fill,
            height: 150.0,
            loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
              if (progress == null) return child;
              return Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String name) {
    return Container(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 10.0,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Google Sans Medium',
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  Widget buildPricePool(double entryFee) {
    var dgnFormatter = NumberFormat.currency(
      name: '',
      decimalDigits: 2,
    );

    return Padding(
      padding: EdgeInsets.only(
        left: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Prizes:',
            style: TextStyle(
              fontFamily: 'Google Sans',
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
              color: mainColor,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            (dgnFormatter.format(entryFee)).toString() + ' DGN',
            style: TextStyle(
              fontFamily: 'Google Sans',
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSeat(int seat, int taken) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        bottom: 7.5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '$seat Seats ($taken Taken)',
            style: TextStyle(
              fontFamily: 'Google Sans',
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
