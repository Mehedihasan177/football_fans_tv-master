class HomeLiveMatches {
  List<Live>? live;

  HomeLiveMatches({this.live});

  HomeLiveMatches.fromJson(Map<String, dynamic> json) {
    if (json['live'] != null) {
      live = <Live>[];
      json['live'].forEach((v) {
        live!.add(Live.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (live != null) {
      data['live'] = live!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Live {
  String? id;
  String? series;
  String? gameId;
  String? t1name;
  String? t1sname;
  String? t1image;
  String? result;
  String? t2name;
  String? t2sname;
  String? t2image;
  String? score;

  Live(
      {this.id,
      this.series,
      this.gameId,
      this.t1name,
      this.t1sname,
      this.t1image,
      this.result,
      this.t2name,
      this.t2sname,
      this.t2image,
      this.score});

  Live.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    series = json['series'];
    gameId = json['gameId'];
    t1name = json['t1name'];
    t1sname = json['t1sname'];
    t1image = json['t1image'];
    result = json['result'];
    t2name = json['t2name'];
    t2sname = json['t2sname'];
    t2image = json['t2image'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['series'] = series;
    data['gameId'] = gameId;
    data['t1name'] = t1name;
    data['t1sname'] = t1sname;
    data['t1image'] = t1image;
    data['result'] = result;
    data['t2name'] = t2name;
    data['t2sname'] = t2sname;
    data['t2image'] = t2image;
    data['score'] = score;
    return data;
  }
}
