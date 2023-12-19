class SignUp {
  bool? status;
  String? accessToken;
  Data? data;

  SignUp({this.status, this.accessToken, this.data});

  SignUp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['access_token'] = accessToken;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? email;
  int? subscriptionId;
  String? expiredAt;
  String? deviceToken;
  String? image;

  Data(
      {this.name,
      this.email,
      this.subscriptionId,
      this.expiredAt,
      this.deviceToken,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    subscriptionId = json['subscription_id'];
    expiredAt = json['expired_at'];
    deviceToken = json['device_token'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['subscription_id'] = subscriptionId;
    data['expired_at'] = expiredAt;
    data['device_token'] = deviceToken;
    data['image'] = image;
    return data;
  }
}
