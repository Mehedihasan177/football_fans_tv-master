class UserModel {
  String? uid;
  String? name;
  String? image;
  String? email;
  String? phone;
  int? color;
  String? provider;

  UserModel(
      {this.uid,
      this.name,
      this.image,
      this.email,
      this.phone,
      this.color,
      this.provider});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phone = json['phone'];
    color = json['color'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['phone'] = phone;
    data['color'] = color;
    data['provider'] = provider;

    return data;
  }
}
