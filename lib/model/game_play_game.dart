class GamePlayGame {
  bool? success;
  List<PlayGameData>? playGameData;
  dynamic? errors;

  GamePlayGame({this.success, this.playGameData, this.errors});

  GamePlayGame.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      playGameData = <PlayGameData>[];
      json['data'].forEach((v) {
        playGameData!.add(new PlayGameData.fromJson(v));
      });
    }
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.playGameData != null) {
      data['data'] = this.playGameData!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class PlayGameData {
  String? id;
  String? gameName;
  String? startTime;
  String? date;
  String? gameResultTime;
  String? lastTime;
  bool? isLocal;

  PlayGameData(
      {this.id,
      this.gameName,
      this.startTime,
      this.date,
      this.gameResultTime,
      this.lastTime,
      this.isLocal});

  PlayGameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameName = json['gameName'];
    startTime = json['startTime'];
    date = json['date'];
    gameResultTime = json['gameResultTime'];
    lastTime = json['lastTime'];
    isLocal = json['isLocal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gameName'] = this.gameName;
    data['startTime'] = this.startTime;
    data['date'] = this.date;
    data['gameResultTime'] = this.gameResultTime;
    data['lastTime'] = this.lastTime;
    data['isLocal'] = this.isLocal;
    return data;
  }
}
