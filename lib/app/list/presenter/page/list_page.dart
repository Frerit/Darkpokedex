import 'package:darkpokedex/app/list/presenter/_widgets/item_row.dart';
import 'package:darkpokedex/app/list/presenter/_widgets/poke_stack.dart';
import 'package:darkpokedex/app/list/presenter/_widgets/types_pokemon.dart';
import 'package:darkpokedex/app/list/presenter/bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListPageView extends StatelessWidget {
  const ListPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListBloc>(
      create: (context) => Modular.get<ListBloc>()..add(GetListPokemonEvent()),
      child: _View(),
    );
  }
}

class _View extends StatelessWidget {
  _View({
    Key? key,
  }) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is LoadingListState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                value: null,
                strokeWidth: 7.0,
              ),
            ),
          );
        }
        if (state is LoadedPokemonState) {
          return Scaffold(
            body: Stack(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 160),
                    primary: false,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 1),
                    itemCount: state.pokemons.length + 1,
                    controller: _scrollController
                      ..addListener(() {
                        if (_scrollController.offset ==
                                _scrollController.position.maxScrollExtent &&
                            !Modular.get<ListBloc>().isFetching) {
                          Modular.get<ListBloc>()
                            ..isFetching = true
                            ..page += 1
                            ..add(GetMoreListPokemonEvent());
                        }
                      }),
                    itemBuilder: (context, index) {
                      final po = state.pokemons[index];
                      if (index == state.pokemons.length) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () =>
                            Modular.to.pushNamed("/details", arguments: po),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 90,
                                    width: 80,
                                    child: Image.network(
                                      po.sprites.other!.officialArtwork
                                          .frontDefault,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        po.name.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.teal.shade800,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      PokemonTypes(po: po),
                                      PokemonStack(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.69,
                                        id: "#${po.id}",
                                        baseStat: "${po.stats.first.baseStat}",
                                        baseExperience: "${po.baseExperience}",
                                        name: po.name,
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.69,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ItemRow(
                                                  left: "Height:",
                                                  right:
                                                      "~ ${(po.weight / 10).toString()} m",
                                                ),
                                                ItemRow(
                                                  left: "Weight:",
                                                  right:
                                                      "~ ${(po.weight / 10).toString()} Kg",
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const ItemRow(
                                                  left: "Generation:",
                                                  right: "I",
                                                ),
                                                ItemRow(
                                                  left: "Candy:",
                                                  right: po.species.name,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ])
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      color: Colors.amber,
                      child: Image.asset("assets/bg.png"),
                    ),
                    Positioned(
                      top: 105,
                      left: 10,
                      right: 160,
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          cursorHeight: 18,
                          onChanged: (value) {
                            Modular.get<ListBloc>().add(
                              FilterPokemonEvent(value, state.pokemons),
                            );
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              hintText: 'Buscar',
                              contentPadding:
                                  EdgeInsets.only(top: 5, bottom: 0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Scaffold();
      },
    );
  }
}
