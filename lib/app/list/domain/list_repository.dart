import 'package:darkpokedex/app/list/data/models/pokemon.dart';
import 'package:darkpokedex/app/list/domain/pokemon.dart';
import 'package:dartz/dartz.dart';

abstract class ListRepository {
  Future<Either<List<PokemonUri>, String>> getPokemonList(int page);
  Future<Either<PokemonModel, String>> getPokemon(String url);
}
