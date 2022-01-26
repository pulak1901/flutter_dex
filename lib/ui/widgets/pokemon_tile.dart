import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonTile({Key? key, required this.pokemon}) : super(key: key);

  List<Widget> _getTiles() {
    List<Widget> tiles = [];

    for (final type in pokemon.types) {
      tiles.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              type.name.capitalize(),
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32), color: Colors.black),
        ),
      ));
    }

    if (tiles.length == 1) {
      tiles.add(const Padding(
        //16, 37, 16, 10 to line up
        padding: EdgeInsets.fromLTRB(16, 37, 16, 10),
      ));
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Text(
                pokemon.name,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getTiles())
          ],
        ),
      ),
    );
  }
}
