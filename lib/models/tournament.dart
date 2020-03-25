import 'package:flutter/cupertino.dart';

class Tournament {
  String id;
  String title;
  String platform;
  num pricePool;
  num entryFee;
  num availableSeats;
  num takenSeats;
  String startTime;
  String pictureUrl;
  String description;
  String status;
  String discordUrl;

  Tournament({
    @required this.id,
    @required this.title,
    @required this.platform,
    @required this.pricePool,
    @required this.entryFee,
    @required this.availableSeats,
    @required this.takenSeats,
    @required this.startTime,
    @required this.pictureUrl,
    @required this.description,
    @required this.status,
    @required this.discordUrl,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'],
      title: json['title'],
      platform: json['platform'],
      pricePool: json['pricePool'],
      entryFee: json['entryFee'],
      availableSeats: json['seats']['available'],
      takenSeats: json['seats']['taken'],
      startTime: json['startTime'],
      pictureUrl: json['pictureUrl'],
      description: json['description'],
      status: json['status'],
      discordUrl: json['discordUrl'],
    );
  }
}
