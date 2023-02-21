class GamePlayGame {
  bool? success;
  List<Data>? data;
  dynamic? errors;

  GamePlayGame({this.success, this.data, this.errors});

  GamePlayGame.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class Data {
  String? id;
  String? gameName;
  String? startTime;
  String? date;
  String? gameResultTime;
  String? lastTime;
  bool? isLocal;

  Data(
      {this.id,
      this.gameName,
      this.startTime,
      this.date,
      this.gameResultTime,
      this.lastTime,
      this.isLocal});

  Data.fromJson(Map<String, dynamic> json) {
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
