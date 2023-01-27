import 'package:darkpokedex/app/list/data/models/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonTypes extends StatelessWidget {
  const PokemonTypes({
    Key? key,
    required this.po,
  }) : super(key: key);

  final PokemonModel po;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          po.types.length,
          (indext) {
            return Row(
              children: [
                Text(
                  "${po.types[indext].type.name.toUpperCase()} ${(indext != po.types.length - 1) ? " / " : ""}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
