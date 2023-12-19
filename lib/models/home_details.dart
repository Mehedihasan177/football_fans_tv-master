class HomeDetails {
  List<League>? league;
  List<Team>? team;
  List<Topstore>? topstore;

  HomeDetails({this.league, this.team, this.topstore});

  HomeDetails.fromJson(Map<String, dynamic> json) {
    if (json['league'] != null) {
      league = <League>[];
      json['league'].forEach((v) {
        league!.add(League.fromJson(v));
      });
    }
    if (json['team'] != null) {
      team = <Team>[];
      json['team'].forEach((v) {
        team!.add(Team.fromJson(v));
      });
    }
    if (json['topstore'] != null) {
      topstore = <Topstore>[];
      json['topstore'].forEach((v) {
        topstore!.add(Topstore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (league != null) {
      data['league'] = league!.map((v) => v.toJson()).toList();
    }
    if (team != null) {
      data['team'] = team!.map((v) => v.toJson()).toList();
    }
    if (topstore != null) {
      data['topstore'] = topstore!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class League {
  String? id;
  String? name;
  String? image;
  String? fixtures;
  String? table;
  String? stats;
  String? teams;
  String? transfers;

  League(
      {this.id,
      this.name,
      this.image,
      this.fixtures,
      this.table,
      this.stats,
      this.teams,
      this.transfers});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    fixtures = json['fixtures'];
    table = json['table'];
    stats = json['stats'];
    teams = json['teams'];
    transfers = json['transfers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['fixtures'] = fixtures;
    data['table'] = table;
    data['stats'] = stats;
    data['teams'] = teams;
    data['transfers'] = transfers;
    return data;
  }
}

class Team {
  String? id;
  String? name;
  String? image;
  String? fixtures;
  String? squad;
  String? stats;
  String? transfers;

  Team(
      {this.id,
      this.name,
      this.image,
      this.fixtures,
      this.squad,
      this.stats,
      this.transfers});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    fixtures = json['fixtures'];
    squad = json['squad'];
    stats = json['stats'];
    transfers = json['transfers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['fixtures'] = fixtures;
    data['squad'] = squad;
    data['stats'] = stats;
    data['transfers'] = transfers;
    return data;
  }
}

class Topstore {
  String? title;
  String? preview;
  String? link;
  String? image;
  Publisher? publisher;

  Topstore({this.title, this.preview, this.link, this.image, this.publisher});

  Topstore.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    preview = json['preview'];
    link = json['link'];
    image = json['image'];
    publisher = json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['preview'] = preview;
    data['link'] = link;
    data['image'] = image;
    if (publisher != null) {
      data['publisher'] = publisher!.toJson();
    }
    return data;
  }
}

class Publisher {
  String? pubName;
  String? pubTime;
  String? pubImg;

  Publisher({this.pubName, this.pubTime, this.pubImg});

  Publisher.fromJson(Map<String, dynamic> json) {
    pubName = json['pub__name'];
    pubTime = json['pub__time'];
    pubImg = json['pubImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pub__name'] = pubName;
    data['pub__time'] = pubTime;
    data['pubImg'] = pubImg;
    return data;
  }
}
