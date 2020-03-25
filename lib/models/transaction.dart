import 'package:flutter/cupertino.dart';

class Transaction {
  String id;
  String transactionType;
  String platform;
  num sentAmount;
  num receivedAmount;
  num entryFee;
  num pricePool;
  String status;
  String description;
  String transactionHash;
  DateTime date;

  Transaction(
      {this.id,
      @required this.transactionType,
      this.platform,
      this.sentAmount,
      this.receivedAmount,
      this.entryFee,
      this.pricePool,
      this.status,
      this.description,
      this.transactionHash,
      this.date});

  factory Transaction.fromJson(json) {
    return Transaction(
      id: json['_id'],
      transactionType: json['transactionType'],
      platform: json['platform'],
      sentAmount: json['sentAmount'],
      receivedAmount: json['receivedAmount'],
      entryFee: json['entryFee'],
      status: json['status'],
      description: json['description'],
      transactionHash: json['transactionHash'],
      date: DateTime.parse(json['date']),
    );
  }
}
