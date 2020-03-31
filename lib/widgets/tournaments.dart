import 'package:flutter/material.dart';
import 'package:diagon/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:diagon/widgets/tournament_item.dart';

class Tournaments extends StatefulWidget {
  @override
  _TournamentsState createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double aspectRatio =
        MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: GridView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.tournaments.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              childAspectRatio: orientation == Orientation.portrait
                  ? aspectRatio <= 1.8 ? 4.5 / 6 : 5.15 / 6
                  : 5.15 / 5.25,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 2.0,
            ),
            itemBuilder: (BuildContext context, int i) => TournamentItem(
              tournament: state.tournaments[i],
            ),
          ),
        );
      },
    );
  }
}
