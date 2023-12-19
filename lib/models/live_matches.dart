class LiveMatches {
  bool? status;
  List<Data>? data;

  LiveMatches({this.status, this.data});

  LiveMatches.fromJson(Map<String, dynamic> json) {
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
  String? matchTitle;
  String? matchTime;
  String? teamOneName;
  String? teamOneImage;
  String? teamTwoName;
  String? teamTwoImage;
  String? coverImageType;
  String? coverUrl;
  String? coverImage;
  int? position;
  List<StreamingSources>? streamingSources;

  Data(
      {this.id,
      this.matchTitle,
      this.matchTime,
      this.teamOneName,
      this.teamOneImage,
      this.teamTwoName,
      this.teamTwoImage,
      this.coverImageType,
      this.coverUrl,
      this.coverImage,
      this.position,
      this.streamingSources});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchTitle = json['match_title'];
    matchTime = json['match_time'];
    teamOneName = json['team_one_name'];
    teamOneImage = json['team_one_image'];
    teamTwoName = json['team_two_name'];
    teamTwoImage = json['team_two_image'];
    coverImageType = json['cover_image_type'];
    coverUrl = json['cover_url'];
    coverImage = json['cover_image'];
    position = json['position'];
    if (json['streaming_sources'] != null) {
      streamingSources = <StreamingSources>[];
      json['streaming_sources'].forEach((v) {
        streamingSources!.add(StreamingSources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_title'] = matchTitle;
    data['match_time'] = matchTime;
    data['team_one_name'] = teamOneName;
    data['team_one_image'] = teamOneImage;
    data['team_two_name'] = teamTwoName;
    data['team_two_image'] = teamTwoImage;
    data['cover_image_type'] = coverImageType;
    data['cover_url'] = coverUrl;
    data['cover_image'] = coverImage;
    data['position'] = position;
    if (streamingSources != null) {
      data['streaming_sources'] =
          streamingSources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StreamingSources {
  int? id;
  int? matchId;
  String? streamTitle;
  String? streamType;
  String? resulation;
  String? streamUrl;
  String? streamKey;
  String? headers;
  int? position;

  StreamingSources(
      {this.id,
      this.matchId,
      this.streamTitle,
      this.streamType,
      this.resulation,
      this.streamUrl,
      this.streamKey,
      this.headers,
      this.position});

  StreamingSources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    streamTitle = json['stream_title'];
    streamType = json['stream_type'];
    resulation = json['resulation'];
    streamUrl = json['stream_url'];
    streamKey = json['stream_key'];
    headers = json['headers'];
    position = json['position'];
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
    data['position'] = position;
    return data;
  }
}
