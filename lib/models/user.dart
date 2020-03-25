import 'package:flutter/cupertino.dart';

class User {
  String id;
  String username;
  String email;
  String jwt;
  String avatar;
  String firstName;
  String lastName;
  DateTime dob;
  String country;
  num dgnWallet;
  num ethWallet;
  num usdWallet;
  String defaultERC20;
  bool isVerified;

  User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.jwt,
    this.avatar,
    this.firstName,
    this.lastName,
    this.dob,
    this.country,
    @required this.dgnWallet,
    this.ethWallet,
    @required this.usdWallet,
    @required this.defaultERC20,
    this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      jwt: json['jwt'],
      avatar: json['avatar'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: DateTime.parse(json['dob']),
      country: json['country'],
      dgnWallet: json['dgnWallet'],
      ethWallet: json['ethWallet'],
      usdWallet: json['usdWallet'],
      defaultERC20: json['defaultERC20'],
      isVerified: json['isVerified'],
    );
  }
}
