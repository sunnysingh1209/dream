import 'package:dream_game/model/game_play_game.dart';

class RouteArguments {
  int? from;
  String? id;
  int? role;
  dynamic? data;
  bool? isUpcoming;
  String? mobileNo;
  PlayGameData? playGameData;

  RouteArguments(
      {this.isUpcoming,
      this.from,
      this.id,
      this.role,
      this.data,
      this.playGameData,
      this.mobileNo});
}
