import 'package:darkpokedex/app/list/data/models/pokemon.dart';
import 'package:darkpokedex/app/list/data/models/response_list.dart';
import 'package:darkpokedex/app/list/domain/list_repository.dart';
import 'package:darkpokedex/app/list/domain/pokemon.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ListRepositoryImp extends ListRepository {
  @override
  Future<Either<List<PokemonUri>, String>> getPokemonList(int page) async {
    try {
      var limit = 20;
      var url = Uri.https(
        'pokeapi.co',
        'api/v2/pokemon/',
        {'offset': '${page * limit}', 'limit': '$limit'},
      );

      var response = await http.get(url);

      print('${response.statusCode} :: Response body: ${response.body}');
      var ret = resultPokemonFromJson(response.body);

      return Left(ret.results);
    } catch (e) {
      // ignore: avoid_print
      print('Response Error: ${e.toString()}');
      return const Right("Error :: ");
    }
  }

  @override
  Future<Either<PokemonModel, String>> getPokemon(String uri) async {
    try {
      var url = Uri.parse(uri);

      var response = await http.get(url);
      print('${response.statusCode} :: Response body: ${response.body}');

      return Left(pokemonModelFromJson(response.body));
    } catch (e) {
      // ignore: avoid_print
      print('Response Error: ${e.toString()}');
      return Right("Error :: ");
    }
  }
}
