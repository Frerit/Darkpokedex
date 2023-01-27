import 'package:darkpokedex/app/list/data/models/pokemon.dart';
import 'package:darkpokedex/app/list/presenter/_widgets/poke_stack.dart';
import 'package:darkpokedex/app/list/presenter/_widgets/types_pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPageView extends StatelessWidget {
  const DetailPageView({Key? key, required this.args});

  final PokemonModel args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Image.asset("assets/bg.png"),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          Positioned(
            top: 120,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Image.network(
                        args.sprites.other!.officialArtwork.frontDefault,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PokemonTypes(po: args),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(args.name.toUpperCase())
                      ],
                    ),
                  ],
                ),
                PokemonStack(
                  width: MediaQuery.of(context).size.width * 0.9,
                  id: "#${args.id}",
                  baseStat: "${args.stats.first.baseStat}",
                  baseExperience: "${args.baseExperience}",
                  name: args.name,
                ),
                Container(
                  child: Column(
                    children: [],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
