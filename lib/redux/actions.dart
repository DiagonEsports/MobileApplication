import 'dart:convert';
import 'package:diagon/models/transaction.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:diagon/models/news.dart';
import 'package:diagon/models/user.dart';
import 'package:diagon/models/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:diagon/models/tournament.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* USER ACTIONS */
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;

  store.dispatch(GetUserAction(user));
};

ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  User user;
  store.dispatch(LogoutUserAction(user));
};

class GetUserAction {
  final User _user;
  User get user => this._user;
  GetUserAction(this._user);
}

class LogoutUserAction {
  final User _user;
  User get user => this._user;
  LogoutUserAction(this._user);
}

/* TOURNAMENT ACTIONS */
ThunkAction<AppState> getTournamentsAction = (Store<AppState> store) async {
  http.Response response =
      await http.get('https://diagon-server.herokuapp.com/api/tournaments');
  final List<dynamic> responseData = json.decode(response.body);
  List<Tournament> tournaments = [];

  responseData.forEach((tournamentData) {
    final Tournament tournament = Tournament.fromJson(tournamentData);
    tournaments.add(tournament);
  });
  store.dispatch(GetTournamentsAction(tournaments));
};

class GetTournamentsAction {
  final List<Tournament> _tournaments;
  List<Tournament> get tournaments => this._tournaments;
  GetTournamentsAction(this._tournaments);
}

/* NEWS ACTIONS */
ThunkAction<AppState> getAllNewsAction = (Store<AppState> store) async {
  http.Response response =
      await http.get('https://diagon-server.herokuapp.com/api/news');
  final List<dynamic> responseData = json.decode(response.body);
  List<News> allNews = [];

  responseData.forEach((newsData) {
    final News news = News.fromJson(newsData);
    allNews.add(news);
  });
  store.dispatch(GetAllNewsAction(allNews));
};

class GetAllNewsAction {
  final List<News> _allNews;
  List<News> get allNews => this._allNews;
  GetAllNewsAction(this._allNews);
}

ThunkAction<AppState> toggleNewsLikeAction(String newsId) {
  return (Store<AppState> store) async {
    final prefs = await SharedPreferences.getInstance();
    final String storedToken = prefs.getString('token');
    final token = storedToken != null ? json.decode(storedToken) : null;

    http.Response response = await http.post(
        'https://diagon-server.herokuapp.com/api/news/like/$newsId',
        headers: {"Authorization": token});
    final List<dynamic> responseData = json.decode(response.body);
    List<News> allNews = [];

    responseData.forEach((newsData) {
      final News news = News.fromJson(newsData);
      allNews.add(news);
    });
    store.dispatch(GetAllNewsAction(allNews));
  };
}

/* TRANSACTION ACTIONS */
ThunkAction<AppState> getTransactionsAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedToken = prefs.getString('token');
  final token = storedToken != null ? json.decode(storedToken) : null;

  http.Response response = await http.get(
    'https://diagon-server.herokuapp.com/api/transactions/',
    headers: {"Authorization": token},
  );

  final List<dynamic> responseData = json.decode(response.body);
  List<Transaction> transactions = [];

  responseData.forEach((transactionData) {
    final Transaction transaction = Transaction.fromJson(transactionData);
    transactions.add(transaction);
  });
  store.dispatch(GetTransactionsAction(transactions));
};

class GetTransactionsAction {
  final List<Transaction> _transactions;
  List<Transaction> get transactions => this._transactions;
  GetTransactionsAction(this._transactions);
}
