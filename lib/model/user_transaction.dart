class UserTransaction {
  bool? success;
  List<UserTransactionData>? userTransactionData;
  dynamic? errors;

  UserTransaction({this.success, this.userTransactionData, this.errors});

  UserTransaction.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      userTransactionData = <UserTransactionData>[];
      json['data'].forEach((v) {
        userTransactionData!.add(new UserTransactionData.fromJson(v));
      });
    }
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.userTransactionData != null) {
      data['data'] = this.userTransactionData!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class UserTransactionData {
  String? id;
  String? tableName;
  String? description;
  String? transactionId;
  String? position;
  double? amount;
  String? createdDate;

  UserTransactionData(
      {this.id,
      this.tableName,
      this.description,
      this.transactionId,
      this.position,
      this.amount,
      this.createdDate});

  UserTransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableName = json['tableName'];
    description = json['description'];
    transactionId = json['transactionId'];
    position = json['position'];
    amount = json['amount'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tableName'] = this.tableName;
    data['description'] = this.description;
    data['transactionId'] = this.transactionId;
    data['position'] = this.position;
    data['amount'] = this.amount;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
