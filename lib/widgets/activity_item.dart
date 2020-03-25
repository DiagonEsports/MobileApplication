import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diagon/models/transaction.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityItem extends StatelessWidget {
  final Transaction transaction;

  ActivityItem({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15.0,
            ),
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFF1E223B),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Color(0XFFED0101).withOpacity(0.5),
                          ),
                          child: Icon(
                            transaction.transactionType == 'Joined Tournament'
                                ? FontAwesomeIcons.signInAlt
                                : FontAwesomeIcons.signOutAlt,
                            color: Color(0XFFE8E8E8),
                            size: 22.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          transaction.transactionType,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Google Sans Medium',
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          transaction.entryFee == 0 ? 'Free' : '50 DGN',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Google Sans',
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      DateFormat.yMMM().format(transaction.date),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
