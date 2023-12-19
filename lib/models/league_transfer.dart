class LeagueTransfers {
  List<Transfers>? transfers;

  LeagueTransfers({this.transfers});

  LeagueTransfers.fromJson(Map<String, dynamic> json) {
    if (json['transfers'] != null) {
      transfers = <Transfers>[];
      json['transfers'].forEach((v) {
        transfers!.add(Transfers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transfers != null) {
      data['transfers'] = transfers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transfers {
  String? date;
  String? player;
  String? fee;
  From? from;
  From? to;

  Transfers({this.date, this.player, this.fee, this.from, this.to});

  Transfers.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    player = json['player'];
    fee = json['fee'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['player'] = player;
    data['fee'] = fee;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    if (to != null) {
      data['to'] = to!.toJson();
    }
    return data;
  }
}

class From {
  String? image;
  String? tname;

  From({this.image, this.tname});

  From.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    tname = json['tname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['tname'] = tname;
    return data;
  }
}
