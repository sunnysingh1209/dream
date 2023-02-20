class UserWallet {
  bool? success;
  WalletData? wallletData;
  dynamic? errors;

  UserWallet({this.success, this.wallletData, this.errors});

  UserWallet.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    wallletData =
        json['data'] != null ? new WalletData.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.wallletData != null) {
      data['data'] = this.wallletData!.toJson();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class WalletData {
  double? winningBalance;
  double? balance;

  WalletData({this.winningBalance = 0, this.balance = 0});

  WalletData.fromJson(Map<String, dynamic> json) {
    winningBalance = json['winningBalance'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['winningBalance'] = this.winningBalance;
    data['balance'] = this.balance;
    return data;
  }
}
