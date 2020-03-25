import 'package:diagon/models/transaction.dart';
import 'package:meta/meta.dart';
import 'package:diagon/models/news.dart';
import 'package:diagon/models/user.dart';
import 'package:diagon/models/tournament.dart';

@immutable
class AppState {
  final User user;
  final List<Tournament> tournaments;
  final List<News> allNews;
  final List<Transaction> transactions;

  AppState({
    @required this.user,
    @required this.tournaments,
    @required this.allNews,
    @required this.transactions,
  });

  factory AppState.initial() {
    return AppState(
      user: null,
      tournaments: [],
      allNews: [],
      transactions: [],
    );
  }
}
