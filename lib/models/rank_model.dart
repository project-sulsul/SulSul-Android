import 'package:sul_sul/models/preference_model.dart';

class RankResponse {
  final String startDate;
  final String endDate;
  final List<dynamic> ranking;

  RankResponse({
    required this.startDate,
    required this.endDate,
    required this.ranking,
  });

  factory RankResponse.fromAlcoholJson(Map<String, dynamic> json) {
    List<AlcoholRankResponse> rankingList = [];
    for (var rank in json['ranking'].toList()) {
      var data = AlcoholRankResponse.fromJson(rank);
      rankingList.add(data);
    }

    return RankResponse(
      startDate: json['start_date'],
      endDate: json['end_date'],
      ranking: rankingList,
    );
  }

}

class AlcoholRankResponse {
  final int rank;
  final PreferenceResponse alcohol;

  AlcoholRankResponse({
    required this.rank,
    required this.alcohol,
  });

  factory AlcoholRankResponse.fromJson(Map<String, dynamic> json) =>
      AlcoholRankResponse(
        rank: json['rank'],
        alcohol: PreferenceResponse.fromJson(json['alcohol']),
      );
}
