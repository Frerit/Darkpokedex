part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetListPokemonEvent extends ListEvent {
  @override
  List<Object?> get props => [];
}

class GetMoreListPokemonEvent extends ListEvent {
  @override
  List<Object?> get props => [];
}

class FilterPokemonEvent extends ListEvent {
  final String filter;
  final List<PokemonModel> pokemons;

  FilterPokemonEvent(this.filter, this.pokemons);
  @override
  List<Object?> get props => [filter, pokemons];
}
