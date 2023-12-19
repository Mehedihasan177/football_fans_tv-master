class SignIn {
  bool? status;
  String? accessToken;
  Data? data;

  SignIn({this.status, this.accessToken, this.data});

  SignIn.fromJson(Map<String, dynamic> json) {
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
  String? phone;
  String? image;
  String? provider;
  int? subscriptionId;
  String? expiredAt;
  String? deviceToken;

  Data(
      {this.name,
      this.email,
      this.phone,
      this.image,
      this.provider,
      this.subscriptionId,
      this.expiredAt,
      this.deviceToken});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    provider = json['provider'];
    subscriptionId = json['subscription_id'];
    expiredAt = json['expired_at'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['provider'] = provider;
    data['subscription_id'] = subscriptionId;
    data['expired_at'] = expiredAt;
    data['device_token'] = deviceToken;
    return data;
  }
}
