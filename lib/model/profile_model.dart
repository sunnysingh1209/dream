class ProfileModel {
  bool? success;
  ProfileData? profileData;
  dynamic? errors;

  ProfileModel({this.success, this.profileData, this.errors});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    profileData = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.profileData != null) {
      data['data'] = this.profileData!.toJson();
    }
    data['errors'] = this.errors;
    return data;
  }
}

class ProfileData {
  String? name;
  String? userImage;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? pincode;
  String? dob;

  ProfileData(
      {this.name,
        this.userImage,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.pincode,
        this.dob});

  ProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userImage = json['userImage'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userImage'] = this.userImage;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['dob'] = this.dob;
    return data;
  }
}