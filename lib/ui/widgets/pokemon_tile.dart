import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

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
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "assets/pokeball.svg",
                  color: const Color.fromRGBO(0, 0, 0, 0.05),
                  width: 60,
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
          Positioned(
            top: 120,
            left: 120,
            child: SvgPicture.asset(
              "assets/pokeball.svg",
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              width: 156,
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
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
          Positioned(
            left: 96,
            top: 90,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image:
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png",
              width: 128,
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}
