import 'package:darkpokedex/app/list/domain/pokemon.dart';

class PokemonUriModel extends PokemonUri {
  PokemonUriModel({
    required String name,
    required String url,
  }) : super(name: name, url: url);

  factory PokemonUriModel.fromJson(Map<String, dynamic> json) =>
      PokemonUriModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
