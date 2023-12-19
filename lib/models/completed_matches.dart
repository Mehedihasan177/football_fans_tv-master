class CompletedMatches {
  List<Ft>? live;
  List<Ft>? ft;

  CompletedMatches({this.live, this.ft});

  CompletedMatches.fromJson(Map<String, dynamic> json) {
    if (json['live'] != null) {
      live = <Ft>[];
      json['live'].forEach((v) {
        live!.add(Ft.fromJson(v));
      });
    }
    if (json['ft'] != null) {
      ft = <Ft>[];
      json['ft'].forEach((v) {
        ft!.add(Ft.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (live != null) {
      data['live'] = live!.map((v) => v.toJson()).toList();
    }
    if (ft != null) {
      data['ft'] = ft!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ft {
  String? id;
  String? gameId;
  String? t1name;
  String? t1image;
  String? result;
  String? t2name;
  String? t2image;
  String? score;

  Ft(
      {this.id,
      this.gameId,
      this.t1name,
      this.t1image,
      this.result,
      this.t2name,
      this.t2image,
      this.score});

  Ft.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameId = json['gameId'];
    t1name = json['t1name'];
    t1image = json['t1image'];
    result = json['result'];
    t2name = json['t2name'];
    t2image = json['t2image'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gameId'] = gameId;
    data['t1name'] = t1name;
    data['t1image'] = t1image;
    data['result'] = result;
    data['t2name'] = t2name;
    data['t2image'] = t2image;
    data['score'] = score;
    return data;
  }
}
