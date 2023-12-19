class Payment {
  bool? status;
  List<Data>? data;

  Payment({this.status, this.data});

  Payment.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? amount;
  String? subscriptionName;
  int? duration;
  String? durationType;

  Data(
      {this.date,
      this.amount,
      this.subscriptionName,
      this.duration,
      this.durationType});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    subscriptionName = json['subscription_name'];
    duration = json['duration'];
    durationType = json['duration_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['amount'] = amount;
    data['subscription_name'] = subscriptionName;
    data['duration'] = duration;
    data['duration_type'] = durationType;
    return data;
  }
}
