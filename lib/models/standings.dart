class LeagueModel {
  List<League>? league;

  LeagueModel({this.league});

  LeagueModel.fromJson(Map<String, dynamic> json) {
    if (json['league'] != null) {
      league = <League>[];
      json['league'].forEach((v) {
        league!.add(League.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (league != null) {
      data['league'] = league!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class League {
  String? name;
  String? image;
  String? schedule;
  String? teams;
  String? stats;

  League({this.name, this.image, this.schedule, this.teams, this.stats});

  League.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    schedule = json['schedule'];
    teams = json['teams'];
    stats = json['stats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['schedule'] = schedule;
    data['teams'] = teams;
    data['stats'] = stats;
    return data;
  }
}
