import 'dart:async';

import 'package:darkpokedex/app/list/data/models/pokemon.dart';
import 'package:darkpokedex/app/list/domain/list_repository.dart';
import 'package:darkpokedex/app/list/domain/pokemon.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc(this.repository) : super(ListInitialState()) {
    on<GetListPokemonEvent>(_onGetListPokemonEvent);
    on<FilterPokemonEvent>(_onFilterPokemonEvent);
    on<GetMoreListPokemonEvent>(_onGetMoreListPokemonEvent);
  }

  ListRepository repository;
  List<PokemonModel> listOriginal = [];
  bool isFetching = false;
  int page = 0;

  void _onGetListPokemonEvent(
    GetListPokemonEvent event,
    Emitter<ListState> emit,
  ) async {
    try {
      emit(LoadingListState());
      final poke = await repository.getPokemonList(0);
      final listpoke = poke.fold((l) => l, (r) {
        emit(FailureServerState());
      });

      List<PokemonModel> resultList = await getDetailFronList(listpoke!);
      listOriginal = resultList;
      emit(LoadedPokemonState(resultList));
    } catch (e) {
      emit(FailureServerState());
    }
  }

  getDetailFronList(List<PokemonUri> listpoke) async {
    List<PokemonModel> list = [];
    for (var e in listpoke) {
      var resultList = await repository.getPokemon(e.url);
      list.add(resultList.fold((l) => l, (r) => PokemonModel.fromJson({})));
    }
    return list;
  }

  _onFilterPokemonEvent(FilterPokemonEvent event, Emitter<ListState> emit) {
    emit(LoadingListState());
    final filter = listOriginal
        .where((element) => element.name.contains(event.filter.toLowerCase()))
        .toList();

    if (filter.isEmpty || event.filter.isEmpty) {
      emit(LoadedPokemonState(listOriginal));
    } else {
      emit(LoadedPokemonState(filter));
    }
  }

  _onGetMoreListPokemonEvent(
      GetMoreListPokemonEvent event, Emitter<ListState> emit) async {
    try {
      final poke = await repository.getPokemonList(page);
      final listpoke = poke.fold((l) => l, (r) {
        emit(FailureServerState());
      });

      List<PokemonModel> resultList = await getDetailFronList(listpoke!);
      listOriginal.addAll(resultList);
      isFetching = false;
      emit(LoadingListState());
      emit(LoadedPokemonState(listOriginal));
    } catch (e) {
      emit(FailureServerState());
    }
  }
}
