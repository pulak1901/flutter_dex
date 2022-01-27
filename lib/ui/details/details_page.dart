import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/model/pokemon_info.dart';
import 'package:flutter_dex/data/model/type_colors.dart';
import 'package:flutter_dex/di/pokemon_info_provider.dart';
import 'package:flutter_dex/ui/widgets/pokemon_entry_tile.dart';
import 'package:flutter_dex/ui/widgets/pokemon_info_tile.dart';
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
  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final info = ref.watch(pokemonInfoProvider(pokemon.id));
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
                    style: const TextStyle(
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
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: info.when(
                  loading: () => const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  error: (err, stack) =>
                      SliverToBoxAdapter(child: Text("Error! $err")),
                  data: (info) {
                    String height = info.height.feet.value!
                            .truncate()
                            .toString() +
                        "′ " +
                        (info.height.inches.value! % 12).truncate().toString() +
                        "″";
                    String weight =
                        info.weight.kilograms.value!.toStringAsPrecision(2) +
                            " kg";

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
            ),
          ],
        ),
      ),
    );
  }
}
