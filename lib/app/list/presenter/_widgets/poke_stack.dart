import 'package:darkpokedex/app/list/presenter/_widgets/beans.dart';
import 'package:flutter/material.dart';

class PokemonStack extends StatelessWidget {
  const PokemonStack({
    Key? key,
    required this.id,
    required this.baseStat,
    required this.name,
    required this.baseExperience,
    required this.width,
  }) : super(key: key);

  final String id;
  final String baseStat;
  final String name;
  final String baseExperience;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: BeansWidget(
        color: const Color.fromRGBO(230, 240, 223, 1),
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              id,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const Text(
              "MAX HP",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            BeansWidget(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              color: const Color.fromRGBO(35, 240, 183, 1),
              child: Row(
                children: [
                  Text(
                    baseStat,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text(
                    "HP",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            const Text(
              "MAX CP",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            BeansWidget(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              color: Colors.purple,
              child: Row(
                children: [
                  const Text(
                    "CP",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    baseExperience.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
