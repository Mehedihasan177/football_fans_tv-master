class SquadList {
  Squad? squad;

  SquadList({this.squad});

  SquadList.fromJson(Map<String, dynamic> json) {
    squad = json['squad'] != null ? Squad.fromJson(json['squad']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (squad != null) {
      data['squad'] = squad!.toJson();
    }
    return data;
  }
}

class Squad {
  List<Goalkeepers>? goalkeepers;
  List<Outfield>? outfield;

  Squad({this.goalkeepers, this.outfield});

  Squad.fromJson(Map<String, dynamic> json) {
    if (json['goalkeepers'] != null) {
      goalkeepers = <Goalkeepers>[];
      json['goalkeepers'].forEach((v) {
        goalkeepers!.add(Goalkeepers.fromJson(v));
      });
    }
    if (json['outfield'] != null) {
      outfield = <Outfield>[];
      json['outfield'].forEach((v) {
        outfield!.add(Outfield.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (goalkeepers != null) {
      data['goalkeepers'] = goalkeepers!.map((v) => v.toJson()).toList();
    }
    if (outfield != null) {
      data['outfield'] = outfield!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Goalkeepers {
  String? name;
  String? jercy;
  String? pos;
  String? age;
  String? ht;
  String? wt;
  String? nat;
  String? app;
  String? sub;
  String? sv;
  String? ga;
  String? a;
  String? fc;
  String? fa;
  String? yc;
  String? rc;

  Goalkeepers(
      {this.name,
      this.jercy,
      this.pos,
      this.age,
      this.ht,
      this.wt,
      this.nat,
      this.app,
      this.sub,
      this.sv,
      this.ga,
      this.a,
      this.fc,
      this.fa,
      this.yc,
      this.rc});

  Goalkeepers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    jercy = json['jercy'];
    pos = json['pos'];
    age = json['age'];
    ht = json['ht'];
    wt = json['wt'];
    nat = json['nat'];
    app = json['app'];
    sub = json['sub'];
    sv = json['sv'];
    ga = json['ga'];
    a = json['a'];
    fc = json['fc'];
    fa = json['fa'];
    yc = json['yc'];
    rc = json['rc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['jercy'] = jercy;
    data['pos'] = pos;
    data['age'] = age;
    data['ht'] = ht;
    data['wt'] = wt;
    data['nat'] = nat;
    data['app'] = app;
    data['sub'] = sub;
    data['sv'] = sv;
    data['ga'] = ga;
    data['a'] = a;
    data['fc'] = fc;
    data['fa'] = fa;
    data['yc'] = yc;
    data['rc'] = rc;
    return data;
  }
}

class Outfield {
  String? name;
  String? jercy;
  String? pos;
  String? age;
  String? ht;
  String? wt;
  String? nat;
  String? app;
  String? sub;
  String? g;
  String? a;
  String? sh;
  String? st;
  String? fc;
  String? fa;
  String? yc;
  String? rc;

  Outfield(
      {this.name,
      this.jercy,
      this.pos,
      this.age,
      this.ht,
      this.wt,
      this.nat,
      this.app,
      this.sub,
      this.g,
      this.a,
      this.sh,
      this.st,
      this.fc,
      this.fa,
      this.yc,
      this.rc});

  Outfield.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    jercy = json['jercy'];
    pos = json['pos'];
    age = json['age'];
    ht = json['ht'];
    wt = json['wt'];
    nat = json['nat'];
    app = json['app'];
    sub = json['sub'];
    g = json['g'];
    a = json['a'];
    sh = json['sh'];
    st = json['st'];
    fc = json['fc'];
    fa = json['fa'];
    yc = json['yc'];
    rc = json['rc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['jercy'] = jercy;
    data['pos'] = pos;
    data['age'] = age;
    data['ht'] = ht;
    data['wt'] = wt;
    data['nat'] = nat;
    data['app'] = app;
    data['sub'] = sub;
    data['g'] = g;
    data['a'] = a;
    data['sh'] = sh;
    data['st'] = st;
    data['fc'] = fc;
    data['fa'] = fa;
    data['yc'] = yc;
    data['rc'] = rc;
    return data;
  }
}
