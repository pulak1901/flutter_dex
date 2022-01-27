import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/model/type_colors.dart';
import 'package:flutter_dex/ui/widgets/pokemon_tile.dart';
import 'package:flutter_dex/ui/widgets/transition_appbar_delegate.dart';
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
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TransitionAppBarDelegate(
                avatar: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          isAntiAlias: true,
                          image: NetworkImage(
                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${widget.pokemon.id}.png"),
                          fit: BoxFit.fitHeight)),
                ),
                avatarBg: SvgPicture.asset(
                  "assets/pokeball.svg",
                  color: Colors.white24,
                  width: 156,
                  fit: BoxFit.cover,
                ),
                title: widget.pokemon.name,
                addiTitle: "#" + widget.pokemon.id.toString().padLeft(3, '0'),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: PokemonTile.getTiles(widget.pokemon.types)),
                bgColors: [
                  TypeColors.getLighterColorOf(widget.pokemon.types[0], 0.3),
                  TypeColors.colorOf[widget.pokemon.types[0]]!,
                ],
                bar: const TabBar(
                  tabs: [
                    Tab(text: "About"),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    Container(color: Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
