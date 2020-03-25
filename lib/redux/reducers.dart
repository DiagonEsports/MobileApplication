import 'package:diagon/models/news.dart';
import 'package:diagon/models/transaction.dart';
import 'package:diagon/models/user.dart';
import 'package:diagon/redux/actions.dart';
import 'package:diagon/models/tournament.dart';
import 'package:diagon/models/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    tournaments: tournamentsReducer(state.tournaments, action),
    allNews: allNewsReducer(state.allNews, action),
    transactions: transactionsReducer(state.transactions, action),
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  }
  return user;
}

List<Tournament> tournamentsReducer(
    List<Tournament> tournaments, dynamic action) {
  if (action is GetTournamentsAction) {
    return action.tournaments;
  }
  return tournaments;
}

List<News> allNewsReducer(List<News> allNews, dynamic action) {
  if (action is GetAllNewsAction) {
    return action.allNews;
  }
  return allNews;
}

List<Transaction> transactionsReducer(
    List<Transaction> transactions, dynamic action) {
  if (action is GetTransactionsAction) {
    return action.transactions;
  }
  return transactions;
}
