import 'dart:convert';

class PokemonsResponse {
  PokemonsResponse({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String next;
  String? previous;
  List<Result> results;

  factory PokemonsResponse.fromJson(String str) => PokemonsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonsResponse.fromMap(Map<String, dynamic> json) => PokemonsResponse(
    count:    json["count"],
    next:     json["next"],
    previous: json["previous"],
    results:  List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count":    count,
    "next":     next,
    "previous": previous,
    "results":  List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class Result {
  Result({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    name: json["name"],
    url:  json["url"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "url":  url,
  };
}
