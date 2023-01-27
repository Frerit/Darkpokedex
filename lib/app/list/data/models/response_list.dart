// To parse this JSON data, do
//
//     final resultPokemon = resultPokemonFromJson(jsonString);

import 'dart:convert';
import 'package:darkpokedex/app/list/data/models/pokemon_uri.dart';

ResultPokemon resultPokemonFromJson(String str) =>
    ResultPokemon.fromJson(json.decode(str));

class ResultPokemon {
  ResultPokemon({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<PokemonUriModel> results;

  factory ResultPokemon.fromJson(Map<String, dynamic> json) => ResultPokemon(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokemonUriModel>.from(
            json["results"].map((x) => PokemonUriModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
