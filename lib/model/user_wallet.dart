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
  double? pendingRequest;
  double? totalBalance;

  WalletData(
      {this.winningBalance = 0,
      this.balance = 0,
      this.pendingRequest = 0,
      this.totalBalance = 0});

  WalletData.fromJson(Map<String, dynamic> json) {
    winningBalance = json['winningBalance'];
    balance = json['balance'];
    pendingRequest = json['pendingRequest'].toDouble();
    totalBalance = (winningBalance! + balance!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['winningBalance'] = this.winningBalance;
    data['balance'] = this.balance;
    data['pendingRequest'] = this.pendingRequest;
    return data;
  }
}
