class Fixtures {
  List<TeamFix>? teamFix;

  Fixtures({this.teamFix});

  Fixtures.fromJson(Map<String, dynamic> json) {
    if (json['team_fix'] != null) {
      teamFix = <TeamFix>[];
      json['team_fix'].forEach((v) {
        teamFix!.add(TeamFix.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamFix != null) {
      data['team_fix'] = teamFix!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamFix {
  String? team1;
  String? image1;
  int? mTime;
  String? team2;
  String? image2;
  String? matchDate;
  String? league;

  TeamFix(
      {this.team1,
      this.image1,
      this.mTime,
      this.team2,
      this.image2,
      this.matchDate,
      this.league});

  TeamFix.fromJson(Map<String, dynamic> json) {
    team1 = json['team1'];
    image1 = json['image1'];
    mTime = json['mTime'];
    team2 = json['team2'];
    image2 = json['image2'];
    matchDate = json['match_date'];
    league = json['league'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team1'] = team1;
    data['image1'] = image1;
    data['mTime'] = mTime;
    data['team2'] = team2;
    data['image2'] = image2;
    data['match_date'] = matchDate;
    data['league'] = league;
    return data;
  }
}
