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

  factory RankResponse.fromCombinationJson(Map<String, dynamic> json) {
    List<CombinationRankResponse> rankingList = [];
    for (var rank in json['ranking'].toList()) {
      var data = CombinationRankResponse.fromJson(rank);
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

class CombinationRankResponse {
  final int rank;
  final List<PreferenceResponse> pairings;
  final String? description;

  CombinationRankResponse({
    required this.rank,
    required this.pairings,
    this.description,
  });

  factory CombinationRankResponse.fromJson(Map<String, dynamic> json) {
    List<PreferenceResponse> rankingList = [];
    for (var pair in json['pairings'].toList()) {
      var data = PreferenceResponse.fromJson(pair);
      rankingList.add(data);
    }

    return CombinationRankResponse(
      rank: json['rank'],
      pairings: rankingList,
      description: json['description'] ?? '',
    );
  }
}
