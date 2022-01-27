import 'package:flutter/material.dart';

class PokemonEntryTile extends StatelessWidget {
  final String species;
  final String entry;
  final List<Color> separatorColors;
  PokemonEntryTile(
      {Key? key,
      required this.species,
      required this.entry,
      required this.separatorColors})
      : super(key: key);

  final TextStyle style = const TextStyle(fontSize: 20);
  final TextStyle entryStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(species, style: style),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 4,
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0.0, 0.15],
                          colors: separatorColors,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(entry, style: entryStyle)
              ],
            )),
      ),
    );
  }
}
