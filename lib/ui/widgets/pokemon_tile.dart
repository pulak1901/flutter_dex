import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/model/type_colors.dart';
import 'package:flutter_dex/data/model/types.dart';
import 'package:flutter_dex/ui/details/extract_details_argument.dart';
import 'package:flutter_dex/ui/widgets/pokemon_type_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonTile({Key? key, required this.pokemon}) : super(key: key);

  static List<Widget> getTiles(List<PokemonType> types) {
    List<Widget> tiles = [];

    for (final type in types) {
      tiles.add(Padding(
        padding: const EdgeInsets.only(top: 12),
        child: PokemonTypeTile(type: type),
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
    final _type = pokemon.types[0];
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            TypeColors.getLighterColorOf(_type, 0.3),
            TypeColors.colorOf[_type]!,
          ], radius: 1.3, center: const Alignment(0.5, 0.3)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 12,
              left: 104,
              child: Text(
                "#" + pokemon.id.toString().padLeft(3, '0'),
                style: const TextStyle(
                    color: Colors.black26,
                    fontFamily: "IBM Plex Sans",
                    fontSize: 40,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 40, 12, 12),
              child: SvgPicture.asset(
                "assets/pokeball.svg",
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                width: 60,
              ),
            ),
            Positioned(
              top: 120,
              left: 120,
              child: SvgPicture.asset(
                "assets/pokeball.svg",
                color: Colors.white24,
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
                    padding: const EdgeInsets.fromLTRB(16, 30, 0, 0),
                    child: Text(
                      pokemon.name,
                      style: const TextStyle(
                          fontFamily: "IBM Plex Sans",
                          fontSize: 24,
                          color: Colors.white,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getTiles(pokemon.types))
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
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: TypeColors.colorOf[_type],
                  onTap: () => {
                    Navigator.pushNamed(
                        context, ExtractDetailsArgumentPage.routeName,
                        arguments: DetailsArguments(pokemon))
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
