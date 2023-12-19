import 'dart:convert';

class LiveSources {
  bool? status;
  List<Data>? data;

  LiveSources({this.status, this.data});

  LiveSources.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? matchId;
  String? streamTitle;
  String? streamType;
  String? resulation;
  String? streamUrl;
  String? streamKey;
  Map<String, String>? headers;

  Data({
    this.id,
    this.matchId,
    this.streamTitle,
    this.streamType,
    this.resulation,
    this.streamUrl,
    this.streamKey,
    Map<String, String>? headers,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    streamTitle = json['stream_title'];
    streamType = json['stream_type'];
    resulation = json['resulation'];
    streamUrl = json['stream_url'];
    streamKey = json['stream_key'];
    headers = (json['headers'] != '' && json['headers'] != null)
        ? jsonDecode(json['headers']).cast<String, String>()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_id'] = matchId;
    data['stream_title'] = streamTitle;
    data['stream_type'] = streamType;
    data['resulation'] = resulation;
    data['stream_url'] = streamUrl;
    data['stream_key'] = streamKey;
    data['headers'] = headers;
    return data;
  }
}
