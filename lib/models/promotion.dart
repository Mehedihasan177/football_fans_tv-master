class Promotion {
  bool? status;
  List<PromotionData>? data;

  Promotion({this.status, this.data});

  Promotion.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PromotionData>[];
      json['data'].forEach((v) {
        data?.add(PromotionData.fromJson(v));
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

class PromotionData {
  String? description;
  String? image;
  String? actionUrl;
  String? promotionType;
  String? video;

  PromotionData(
      {this.description,
      this.image,
      this.actionUrl,
      this.promotionType,
      this.video});

  PromotionData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    image = json['image'];
    actionUrl = json['action_url'];
    promotionType = json['promotion_type'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['image'] = image;
    data['action_url'] = actionUrl;
    data['promotion_type'] = promotionType;
    data['video'] = video;
    return data;
  }
}
