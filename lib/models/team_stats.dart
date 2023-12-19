class TeamStats {
  Stats? stats;

  TeamStats({this.stats});

  TeamStats.fromJson(Map<String, dynamic> json) {
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
  }
}

class Stats {
  List<TopScorers>? topScorers;
  List<TopAssists>? topAssists;

  Stats({this.topScorers, this.topAssists});

  Stats.fromJson(Map<String, dynamic> json) {
    if (json['top_scorers'] != null) {
      topScorers = <TopScorers>[];
      json['top_scorers'].forEach((v) {
        topScorers!.add(TopScorers.fromJson(v));
      });
    }
    if (json['top_assists'] != null) {
      topAssists = <TopAssists>[];
      json['top_assists'].forEach((v) {
        topAssists!.add(TopAssists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topScorers != null) {
      data['top_scorers'] = topScorers!.map((v) => v.toJson()).toList();
    }
    if (topAssists != null) {
      data['top_assists'] = topAssists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopScorers {
  String? rk;
  String? name;
  String? p;
  String? g;

  TopScorers({this.rk, this.name, this.p, this.g});

  TopScorers.fromJson(Map<String, dynamic> json) {
    rk = json['rk'];
    name = json['name'];
    p = json['p'];
    g = json['g'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rk'] = rk;
    data['name'] = name;
    data['p'] = p;
    data['g'] = g;
    return data;
  }
}

class TopAssists {
  String? rk;
  String? name;
  String? p;
  String? a;

  TopAssists({this.rk, this.name, this.p, this.a});

  TopAssists.fromJson(Map<String, dynamic> json) {
    rk = json['rk'];
    name = json['name'];
    p = json['p'];
    a = json['a'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rk'] = rk;
    data['name'] = name;
    data['p'] = p;
    data['a'] = a;
    return data;
  }
}
