class PaymentGatewayModel {
  bool? success;
  List<String>? data;
  dynamic? errors;

  PaymentGatewayModel({this.success, this.data, this.errors});

  PaymentGatewayModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['errors'] = this.errors;
    return data;
  }
}