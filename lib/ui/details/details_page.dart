import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/model/type_colors.dart';
import 'package:flutter_dex/ui/widgets/pokemon_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsPage extends StatefulWidget {
  final Pokemon pokemon;

  DetailsPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailsState();
  }
}

class _DetailsState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final _type = pokemon.types.first;
    final _color = TypeColors.getLighterColorOf(_type, 0.1);

    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 160.0,
              backgroundColor: _color,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(pokemon.name,
                    style: TextStyle(
                        letterSpacing: 1.4, fontWeight: FontWeight.w800)),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      TypeColors.getLighterColorOf(_type, 0.3),
                      TypeColors.colorOf[_type]!,
                    ], radius: 1.3, center: const Alignment(0, 0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 64),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: PokemonTile.getTiles(pokemon.types),
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned(
                            left: 80,
                            top: 50,
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
                            padding: const EdgeInsets.only(top: 20, right: 32),
                            child: Image.network(
                                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${widget.pokemon.id}.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Scroll to see the SliverAppBar in effect.'),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
