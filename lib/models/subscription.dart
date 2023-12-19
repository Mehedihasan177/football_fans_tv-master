class Subscription {
  bool? status;
  List<Data>? data;

  Subscription({this.status, this.data});

  Subscription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? durationType;
  int? duration;
  String? platform;
  String? productId;

  Data(
      {this.id,
      this.name,
      this.description,
      this.durationType,
      this.duration,
      this.platform,
      this.productId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    durationType = json['duration_type'];
    duration = json['duration'];
    platform = json['platform'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['duration_type'] = durationType;
    data['duration'] = duration;
    data['platform'] = platform;
    data['product_id'] = productId;
    return data;
  }
}
