class User {
  String? name;
  String? phone;
  int? subscriptionId;
  String? expiredAt;
  String? deviceToken;
  String? provider;
  String? email;
  String? subscriptionName;
  String? image;

  User(
      {this.name,
      this.phone,
      this.subscriptionId,
      this.expiredAt,
      this.deviceToken,
      this.provider,
      this.email,
      this.subscriptionName,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    subscriptionId = json['subscription_id'];
    expiredAt = json['expired_at'];
    deviceToken = json['device_token'];
    provider = json['provider'];
    email = json['email'];
    subscriptionName = json['subscription_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['subscription_id'] = subscriptionId;
    data['expired_at'] = expiredAt;
    data['device_token'] = deviceToken;
    data['provider'] = provider;
    data['email'] = email;
    data['subscription_name'] = subscriptionName;
    data['image'] = image;
    return data;
  }
}
