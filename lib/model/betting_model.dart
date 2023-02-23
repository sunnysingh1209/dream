class BettingModel {
  int? number;
  int? amount;
  bool? isSelected;

  BettingModel({this.amount = 0, this.number, this.isSelected = false});

  BettingModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['number'] = this.number;
    return data;
  }
}