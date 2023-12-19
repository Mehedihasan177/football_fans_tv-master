class HighlightModel {
  bool? status;
  List<HighLight>? highlight;

  HighlightModel({this.status, this.highlight});

  HighlightModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      highlight = <HighLight>[];
      json['data'].forEach((v) {
        highlight!.add(HighLight.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (highlight != null) {
      data['data'] = highlight!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HighLight {
  int? id;
  String? matchTitle;
  String? teamOneName;
  String? teamOneImage;
  String? teamTwoName;
  String? teamTwoImage;
  String? coverImageType;
  String? coverUrl;
  String? coverImage;
  List<StreamingSources>? streamingSources;

  HighLight(
      {this.id,
      this.matchTitle,
      this.teamOneName,
      this.teamOneImage,
      this.teamTwoName,
      this.teamTwoImage,
      this.coverImageType,
      this.coverUrl,
      this.coverImage,
      this.streamingSources});

  HighLight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchTitle = json['match_title'];
    teamOneName = json['team_one_name'];
    teamOneImage = json['team_one_image'];
    teamTwoName = json['team_two_name'];
    teamTwoImage = json['team_two_image'];
    coverImageType = json['cover_image_type'];
    coverUrl = json['cover_url'];
    coverImage = json['cover_image'];
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
    data['team_one_name'] = teamOneName;
    data['team_one_image'] = teamOneImage;
    data['team_two_name'] = teamTwoName;
    data['team_two_image'] = teamTwoImage;
    data['cover_image_type'] = coverImageType;
    data['cover_url'] = coverUrl;
    data['cover_image'] = coverImage;
    if (streamingSources != null) {
      data['streaming_sources'] =
          streamingSources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StreamingSources {
  int? id;
  int? highlightId;
  String? streamTitle;
  String? streamType;
  String? resulation;
  String? streamUrl;
  String? streamKey;
  String? headers;

  StreamingSources(
      {this.id,
      this.highlightId,
      this.streamTitle,
      this.streamType,
      this.resulation,
      this.streamUrl,
      this.streamKey,
      this.headers});

  StreamingSources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    highlightId = json['highlight_id'];
    streamTitle = json['stream_title'];
    streamType = json['stream_type'];
    resulation = json['resulation'];
    streamUrl = json['stream_url'];
    streamKey = json['stream_key'];
    headers = json['headers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['highlight_id'] = highlightId;
    data['stream_title'] = streamTitle;
    data['stream_type'] = streamType;
    data['resulation'] = resulation;
    data['stream_url'] = streamUrl;
    data['stream_key'] = streamKey;
    data['headers'] = headers;
    return data;
  }
}
