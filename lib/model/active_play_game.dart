class ActivePlayGame {
  bool? success;
  List<Data>? data;

  ActivePlayGame({
    this.success,
    this.data,
  });

  ActivePlayGame.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? date;
  String? gameId;
  String? gameName;
  double? amount;
  int? gameNumber;
  String? status;

  Data(
      {this.id,
      this.date,
      this.gameId,
      this.gameName,
      this.amount,
      this.gameNumber,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    gameId = json['gameId'];
    gameName = json['gameName'];
    amount = json['amount'];
    gameNumber = json['gameNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['gameId'] = this.gameId;
    data['gameName'] = this.gameName;
    data['amount'] = this.amount;
    data['gameNumber'] = this.gameNumber;
    data['status'] = this.status;
    return data;
  }
}
