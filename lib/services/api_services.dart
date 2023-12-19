import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/controllers/auth_controller.dart';
import '/models/completed_matches.dart';
import '/models/home_news_details.dart';
import '/models/payment.dart';
import '/models/promotion.dart';
import '/models/subscription.dart';
import '/utils/helpers.dart';
import '/utils/widgets.dart';
import '../consts/app_consts.dart';
import '../models/commentary.dart';
import '../models/fixtures.dart';
import '../models/header.dart' as head;
import '../models/highlight_model.dart';
import '../models/home_details.dart';
import '../models/home_live_matches.dart';
import '../models/league_fixtures.dart';
import '../models/league_table.dart';
import '../models/league_teams.dart';
import '../models/league_transfer.dart';
import '../models/lineups.dart';
import '../models/live_matches.dart';
import '../models/live_stream_model.dart';
import '../models/main_news.dart';
import '../models/match_schedule.dart';
import '../models/newslist.dart';
import '../models/prediction.dart';
import '../models/setting.dart';
import '../models/squads.dart';
import '../models/standings.dart';
import '../models/statistics.dart';
import '../models/team_stats.dart';
import '../models/team_transfer.dart';

class ApiService {
  static var client = http.Client();

  static AuthController authController = Get.find();

  static Future<Setting> loadsettings() async {
    var response = await client.post(
      //Uri.parse(ApiConsts.BASE_URL + ApiConsts.SETTINGS + ApiConsts.AppId),
      Uri.parse(
          'https://supersports24.xyz/api/v1/settings/1660644401_945220690'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );

    dd(Uri.parse(ApiConsts.BASE_URL + ApiConsts.SETTINGS + ApiConsts.AppId));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Setting.fromJson(jsonDecode(jsonString));
    } else {
      return Setting();
    }
  }

  static Future<Map> signIn(Map data) async {
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;
    data['device_token'] = await deviceToken();

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.signIn);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return {};
    }
  }

  static Future<Map> signUp(Map data) async {
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;
    data['device_token'] = await deviceToken();

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.signUp);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return {};
    }
  }

  static Future<Map> loadUser() async {
    Map data = {};
    data['api_key'] = ApiConsts.API_KEY;

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.user);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authController.token.value}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return {};
    }
  }

  static Future<Map> forgetPassword(Map data) async {
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.forgetPassword);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return {};
    }
  }

  static Future<Subscription> loadSubscriptions() async {
    Map data = {};
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.subscriptions);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Subscription.fromJson(jsonDecode(jsonString));
    } else {
      return Subscription();
    }
  }

  static Future<Map> subscriptionUpdate(Map data) async {
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.subscriptionUpdate);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authController.token.value}'
      },
      body: jsonEncode(data),
    );

    dd(response.body);
    dd(data);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return {};
    }
  }

  static Future<Map> subscriptionExpired() async {
    Map data = {};
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.subscriptionExpired);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authController.token.value}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return {};
    }
  }

  static Future<Map> subscriptionRestore(Map data) async {
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.subscriptionRestore);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authController.token.value}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return {};
    }
  }

  static Future<Payment> loadPayments() async {
    Map data = {};
    data['api_key'] = ApiConsts.API_KEY;
    data['app_id'] = ApiConsts.AppId;

    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.payments);

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authController.token.value}'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Payment.fromJson(jsonDecode(jsonString));
    } else {
      return Payment();
    }
  }

  static Future<HomeDetails> loadHome() async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.home),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return HomeDetails.fromJson(jsonDecode(jsonString));
    } else {
      return HomeDetails();
    }
  }

  static Future<HomeNewsDetails> loadhomenewsDetails(String url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.topnewsdetails),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
        'url': url,
      }),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return HomeNewsDetails.fromJson(jsonDecode(jsonString));
    } else {
      return HomeNewsDetails();
    }
  }

  static Future<MatchSchedule> loadFootballSchedule(matchDate, type) async {
    Uri uri = Uri.parse(ApiConsts.BASE_URL + ApiConsts.schedule);

    String body = jsonEncode(<String, dynamic>{
      'api_key': ApiConsts.API_KEY,
      'date': matchDate,
      'type': type,
    });

    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return MatchSchedule.fromJson(jsonDecode(jsonString));
    } else {
      return MatchSchedule();
    }
  }

  static Future<HomeLiveMatches> loadHomeMatches() async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.livehomematches),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );

    //print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return HomeLiveMatches.fromJson(jsonDecode(jsonString));
    } else {
      return HomeLiveMatches();
    }
  }

  static Future<CompletedMatches> loadcompletedmatches() async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.finished),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );

    //   print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return CompletedMatches.fromJson(jsonDecode(jsonString));
    } else {
      return CompletedMatches();
    }
  }

  static Future<Prediction> laodPrediction() async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.predictions + ApiConsts.AppId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Prediction.fromJson(jsonDecode(jsonString));
    } else {
      return Prediction();
    }
  }

  static Future<LiveMatches> loadLiveMatches() async {
    var response = await client.post(
      Uri.parse(
          ApiConsts.live_base + ApiConsts.LIVE_MATCHES + ApiConsts.live_app_id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return LiveMatches.fromJson(jsonDecode(jsonString));
    } else {
      return LiveMatches();
    }
  }

  static Future<HighlightModel> loadHighlight() async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.highlights + ApiConsts.AppId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return HighlightModel.fromJson(jsonDecode(jsonString));
    } else {
      return HighlightModel();
    }
  }

  static Future<LiveStreamModel> loadLiveMatchesStraming(matchid) async {
    var response = await client.post(
      Uri.parse(
          "${ApiConsts.BASE_URL}${ApiConsts.live_streaming}${ApiConsts.AppId}/$matchid"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'api_key': ApiConsts.API_KEY}),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      //print(jsonString);
      return LiveStreamModel.fromJson(jsonDecode(jsonString));
    } else {
      return LiveStreamModel();
    }
  }

  static Future<List<MainNews>> loadMainNews(name) async {
    var response = await client.post(
      Uri.parse(ApiConsts.NEWS_API),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.NEWS_API_KEY,
        'type': name,
      }),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // print(jsonString);
      // return MainNews.fromJson(jsonDecode(jsonString));
      return [
        for (final item in jsonDecode(jsonString)) MainNews.fromJson(item),
      ];
    } else {
      //show error message
      return <MainNews>[];
    }
  }

  static Future<NewsModel> loadnews() async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.news),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );
    //print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      return NewsModel.fromJson(jsonDecode(jsonString));
    } else {
      return NewsModel();
    }
  }
/////////////////////////////////////////////////////////////////////////
  ///

  static Future<LeagueFixtureList> loadfixturesLeague(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.fixturesLeague),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return LeagueFixtureList.fromJson(jsonDecode(jsonString));
    } else {
      return LeagueFixtureList();
    }
  }

  static Future<Fixtures> loadfixtures(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.fixtures),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Fixtures.fromJson(jsonDecode(jsonString));
    } else {
      return Fixtures();
    }
  }

  static Future<TeamTransfers> loadTeamTransfers(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.transfers),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return TeamTransfers.fromJson(jsonDecode(jsonString));
    } else {
      return TeamTransfers();
    }
  }

  static Future<TeamStats> loadteamstats(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.stats),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return TeamStats.fromJson(jsonDecode(jsonString));
    } else {
      return TeamStats();
    }
  }

  static Future<SquadList> loadSquads(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.squads),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    //  print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return SquadList.fromJson(jsonDecode(jsonString));
    } else {
      return SquadList();
    }
  }

  static Future<LeagueTable> loadTableLeague(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.tableLeague),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    //print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return LeagueTable.fromJson(jsonDecode(jsonString));
    } else {
      return LeagueTable();
    }
  }

  static Future<TeamStats> loadLeagueStats(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.statsLeague),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      //  print(jsonString);
      return TeamStats.fromJson(jsonDecode(jsonString));
    } else {
      return TeamStats();
    }
  }

  static Future<LeagueTransfers> loadLeagueTransfer(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.transferLeague),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return LeagueTransfers.fromJson(jsonDecode(jsonString));
    } else {
      return LeagueTransfers();
    }
  }

  static Future<LeagueTeams> loadLeagueTeams(url) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.teamLeague),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'api_key': ApiConsts.API_KEY, 'url': url}),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      //print(jsonString);
      return LeagueTeams.fromJson(jsonDecode(jsonString));
    } else {
      return LeagueTeams();
    }
  }

  static Future<LeagueModel> loadStandings() async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.standingsleague),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
      }),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return LeagueModel.fromJson(jsonDecode(jsonString));
    } else {
      return LeagueModel();
    }
  }

  ////////////////////////
  ///
  ///
  static Future<head.Header> loadheader(id) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.matchheader),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
        'gameId': id,
      }),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return head.Header.fromJson(jsonDecode(jsonString));
    } else {
      return head.Header();
    }
  }

  static Future<Statistics> loadstats(id) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.matchstats),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
        'gameId': id,
      }),
    );

    // print(response.body);
    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return Statistics.fromJson(jsonDecode(jsonString));
      } else {
        return Statistics();
      }
    } catch (e) {
      dd(e);
      return Statistics();
    }
  }

  static Future<LineUps> loadlineups(id, int team) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.matchlineup),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
        'gameId': id,
        'teamNo': team.toString(),
      }),
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return LineUps.fromJson(jsonDecode(jsonString));
    } else {
      return LineUps();
    }
  }

  static Future<CommentaryList> loadcommentary(id) async {
    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.matchcommentary),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': ApiConsts.API_KEY,
        'gameId': id,
      }),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return CommentaryList.fromJson(jsonDecode(jsonString));
    } else {
      return CommentaryList();
    }
  }

  /////////////////////////

  static Future addUser(data) async {
    data['api_key'] = ApiConsts.API_KEY;

    var response = await client.post(
      Uri.parse(ApiConsts.BASE_URL + ApiConsts.ADD_USER + ApiConsts.AppId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return jsonDecode(jsonString);
    } else {
      return null;
    }
  }

  static Future<Promotion> loadPromotions() async {
    var data = {};
    data['api_key'] = ApiConsts.API_KEY;

    var response = await client.post(
      Uri.parse('${ApiConsts.BASE_URL}api/v1/promotions/${ApiConsts.AppId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return Promotion.fromJson(jsonDecode(jsonString));
    } else {
      return Promotion();
    }
  }
}
