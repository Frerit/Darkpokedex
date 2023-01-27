part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListInitialState extends ListState {
  @override
  List<Object?> get props => [];
}

class LoadingListState extends ListState {
  @override
  List<Object?> get props => [];
}

class FailureServerState extends ListState {
  @override
  List<Object?> get props => [];
}

class LoadedPokemonState extends ListState {
  LoadedPokemonState(this.pokemons);
  final List<PokemonModel> pokemons;

  @override
  List<Object?> get props => [pokemons];
}
