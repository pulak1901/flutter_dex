import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/model/pokemon_info.dart';
import 'package:flutter_dex/data/model/pokemon_moves.dart';
import 'package:flutter_dex/data/model/type_colors.dart';
import 'package:flutter_dex/di/pokemon_info_provider.dart';
import 'package:flutter_dex/di/pokemon_moves_provider.dart';
import 'package:flutter_dex/ui/widgets/pokemon_entry_tile.dart';
import 'package:flutter_dex/ui/widgets/pokemon_info_tile.dart';
import 'package:flutter_dex/ui/widgets/pokemon_move_tile.dart';
import 'package:flutter_dex/ui/widgets/pokemon_stats_tile.dart';
import 'package:flutter_dex/ui/widgets/pokemon_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsPage extends ConsumerStatefulWidget {
  final Pokemon pokemon;

  DetailsPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DetailsState();
  }
}

class _DetailsState extends ConsumerState<DetailsPage> {
  final List<String> _tabs = <String>['Info', 'Learnset', 'HMs', 'TMs'];
  final TextStyle style = const TextStyle(fontSize: 16);

  Widget _getTabContents(String name, AsyncValue<PokemonInfo> info,
      AsyncValue<List<List<PokemonMove>>> moves) {
    final _type = widget.pokemon.types.first;
    if (name == _tabs[0]) {
      return SliverPadding(
        padding: const EdgeInsets.all(24),
        sliver: info.when(
            loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
            error: (err, stack) =>
                SliverToBoxAdapter(child: Text("Error! $err")),
            data: (info) {
              String height = info.height.feet.value!.truncate().toString() +
                  "′ " +
                  (info.height.inches.value! % 12).truncate().toString() +
                  "″";
              String weight =
                  info.weight.kilograms.value!.toStringAsPrecision(2) + " kg";

              return SliverList(
                  delegate: SliverChildListDelegate([
                PokemonEntryTile(
                    species: info.species,
                    entry: info.entry,
                    separatorColors: [
                      TypeColors.getLighterColorOf(_type, 0.3),
                      TypeColors.colorOf[_type]!,
                    ]),
                const SizedBox(
                  height: 16,
                ),
                PokemonInfoTile(
                    height: height,
                    weight: weight,
                    genderRate: info.genderRate,
                    catchRate: info.captureRate),
                const SizedBox(
                  height: 16,
                ),
                PokemonStatsTile(stats: info.baseStats),
              ]));
            }),
      );
    } else {
      int i = 0;
      String msg = "This Pokémon cannot learn any moves by levelling up.";
      if (name == 'HMs') {
        i = 1;
        msg = "This Pokémon cannot learn any moves from HMs.";
      } else if (name == 'TMs') {
        i = 2;
        msg = "This Pokémon cannot learn any moves from TMs.";
      }

      return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: moves.when(
              loading: () => const SliverFillRemaining(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              error: (err, stack) =>
                  SliverToBoxAdapter(child: Text("Error! $err")),
              data: (info) {
                if (info[i].isEmpty) {
                  return SliverToBoxAdapter(
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          msg,
                          style: style,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            PokemonMoveTile(move: info[i][index]),
                        childCount: info[i].length),
                  );
                }
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final info = ref.watch(pokemonInfoProvider(pokemon.id));

    final _type = pokemon.types.first;
    final _color = TypeColors.getLighterColorOf(_type, 0.1);

    final moves = ref.watch(PokemonMovesProvider(pokemon.id));

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pokemon.name,
                          style: const TextStyle(
                              fontSize: 38,
                              color: Colors.white70,
                              letterSpacing: 1.4,
                              fontWeight: FontWeight.w800)),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text("#" + pokemon.id.toString().padLeft(3, '0'),
                            style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 38,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                  backgroundColor: _color,
                  pinned: true,
                  expandedHeight: 250.0,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                      background: _FlexibleSpaceBarBg(
                    pokemon: pokemon,
                  )),
                  bottom: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: _getTabContents(name, info, moves)),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _FlexibleSpaceBarBg extends StatelessWidget {
  final Pokemon pokemon;
  const _FlexibleSpaceBarBg({Key? key, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _type = pokemon.types.first;
    final _tiles = PokemonTile.getTiles(pokemon.types);

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [
          TypeColors.getLighterColorOf(_type, 0.3),
          TypeColors.colorOf[_type]!,
        ], radius: 1, center: const Alignment(0.1, 0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 58),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [..._tiles],
            ),
          ),
          Stack(
            children: [
              Positioned(
                top: 32,
                child: SvgPicture.asset(
                  "assets/pokeball.svg",
                  color: Colors.white24,
                  width: 256,
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, right: 16, bottom: 24),
                child: Image.network(
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
