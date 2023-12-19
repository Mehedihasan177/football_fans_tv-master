class TeamTransfers {
  Transfers? transfers;

  TeamTransfers({this.transfers});

  TeamTransfers.fromJson(Map<String, dynamic> json) {
    transfers = json['transfers'] != null
        ? Transfers.fromJson(json['transfers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transfers != null) {
      data['transfers'] = transfers!.toJson();
    }
    return data;
  }
}

class Transfers {
  List<PlayersIn>? playersIn;
  List<PlayersOut>? playersOut;

  Transfers({this.playersIn, this.playersOut});

  Transfers.fromJson(Map<String, dynamic> json) {
    if (json['players_in'] != null) {
      playersIn = <PlayersIn>[];
      json['players_in'].forEach((v) {
        playersIn!.add(PlayersIn.fromJson(v));
      });
    }
    if (json['players_out'] != null) {
      playersOut = <PlayersOut>[];
      json['players_out'].forEach((v) {
        playersOut!.add(PlayersOut.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (playersIn != null) {
      data['players_in'] = playersIn!.map((v) => v.toJson()).toList();
    }
    if (playersOut != null) {
      data['players_out'] = playersOut!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayersIn {
  String? date;
  String? name;
  String? imgId;
  String? from;
  String? fee;

  PlayersIn({this.date, this.name, this.imgId, this.from, this.fee});

  PlayersIn.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    name = json['name'];
    imgId = json['imgId'];
    from = json['from'];
    fee = json['fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['name'] = name;
    data['imgId'] = imgId;
    data['from'] = from;
    data['fee'] = fee;
    return data;
  }
}

class PlayersOut {
  String? date;
  String? name;
  String? imgId;
  String? from;
  String? fee;

  PlayersOut({this.date, this.name, this.imgId, this.from, this.fee});

  PlayersOut.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    name = json['name'];
    imgId = json['imgId'];
    from = json['from'];
    fee = json['fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['name'] = name;
    data['imgId'] = imgId;
    data['from'] = from;
    data['fee'] = fee;
    return data;
  }
}
