import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon_moves.dart';
import 'package:flutter_dex/ui/widgets/pokemon_damageclasstype_tile.dart';
import 'package:flutter_dex/ui/widgets/pokemon_type_tile.dart';

class PokemonMoveTile extends StatelessWidget {
  final TextStyle flavorStyle = const TextStyle(
    fontSize: 16,
    fontFamily: "IBM Plex Mono",
  );
  final TextStyle colStyle = const TextStyle(
    fontSize: 18,
    fontFamily: "IBM Plex Sans",
  );
  final TextStyle nameStyle = const TextStyle(
    fontSize: 20,
    fontFamily: "IBM Plex Sans",
  );
  final TextStyle levelStyle = const TextStyle(
    fontSize: 24,
    fontFamily: "IBM Plex Mono",
  );
  final TextStyle valueStyle = const TextStyle(
    fontSize: 18,
    fontFamily: "IBM Plex Mono",
  );

  final PokemonMove move;

  const PokemonMoveTile({Key? key, required this.move}) : super(key: key);

  String _getValueAsString(int val, int width) {
    if (val == 0) {
      return "---";
    } else {
      return val.toString().padLeft(width, ' ');
    }
  }

  Widget _getLearnMethod() {
    if (move.learnMethod == 'level-up') {
      return Column(
        children: [
          Text(
            "Level",
            style: valueStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            move.level.toString(),
            style: levelStyle,
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      String machineType = move.machine.substring(0, 2).toLowerCase();
      String type = move.type.name;
      return Column(
        children: [
          Image.asset(
            "assets/$machineType/$type.webp",
            scale: 0.8,
          ),
          Text(
            move.machine,
            style: valueStyle,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: _getLearnMethod()),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          move.name,
                          style: nameStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(move.flavorTextLine1, style: flavorStyle),
                        if (move.flavorTextLine2 != '')
                          Text(move.flavorTextLine2, style: flavorStyle),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        PokemonTypeTile(type: move.type),
                        const SizedBox(
                          height: 8,
                        ),
                        PokemonDamageClassTile(damageClass: move.damageClass)
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: DataTable(headingRowHeight: 0, columns: const [
                      DataColumn(label: Text("")),
                      DataColumn(label: Text(""))
                    ], rows: [
                      DataRow(cells: [
                        DataCell(Text(
                          "Accuracy",
                          style: valueStyle,
                        )),
                        DataCell(SizedBox(
                          width: double.infinity,
                          child: Text(
                            _getValueAsString(move.accuracy, 3),
                            style: valueStyle,
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "Power",
                          style: valueStyle,
                        )),
                        DataCell(SizedBox(
                          width: double.infinity,
                          child: Text(
                            _getValueAsString(move.power, 3),
                            style: valueStyle,
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          "PP",
                          style: valueStyle,
                        )),
                        DataCell(SizedBox(
                          width: double.infinity,
                          child: Text(
                            _getValueAsString(move.pp, 3),
                            style: valueStyle,
                            textAlign: TextAlign.right,
                          ),
                        )),
                      ])
                    ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
