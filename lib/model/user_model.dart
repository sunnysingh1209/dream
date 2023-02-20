// const UserModel(this.id);
//
// final String id;
//
// @override
// List<Object> get props => [id];
//
// static const empty = UserModel('-');

class UserModel {
  bool? success;
  Data? data;
  String? errors;

  UserModel({this.success, this.data, this.errors});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? username;
  String? userImage;
  String? emailId;
  bool? isEmailVerified;
  String? mobileNumber;
  String? role;
  bool? isMobileVerified;
  TokenResponse? tokenResponse;

  Data(
      {this.id,
      this.name,
      this.username,
      this.userImage,
      this.emailId,
      this.isEmailVerified,
      this.mobileNumber,
      this.role,
      this.isMobileVerified,
      this.tokenResponse});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    userImage = json['userImage'];
    emailId = json['emailId'];
    isEmailVerified = json['isEmailVerified'];
    mobileNumber = json['mobileNumber'];
    role = json['role'];
    isMobileVerified = json['isMobileVerified'];
    tokenResponse = json['tokenResponse'] != null
        ? new TokenResponse.fromJson(json['tokenResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['userImage'] = this.userImage;
    data['emailId'] = this.emailId;
    data['isEmailVerified'] = this.isEmailVerified;
    data['mobileNumber'] = this.mobileNumber;
    data['role'] = this.role;
    data['isMobileVerified'] = this.isMobileVerified;
    if (this.tokenResponse != null) {
      data['tokenResponse'] = this.tokenResponse!.toJson();
    }
    return data;
  }
}

class TokenResponse {
  String? token;
  String? refreshToken;

  TokenResponse({this.token, this.refreshToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
