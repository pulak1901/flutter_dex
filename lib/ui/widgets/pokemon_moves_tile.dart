import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon_moves.dart';
import 'package:flutter_dex/ui/widgets/pokemon_type_tile.dart';

class PokemonMovesTile extends StatelessWidget {
  final List<PokemonMove> moves;
  const PokemonMovesTile({Key? key, required this.moves}) : super(key: key);

  final TextStyle titleStyle = const TextStyle(fontSize: 24);
  final TextStyle style = const TextStyle(fontSize: 16);
  final TextStyle colStyle = const TextStyle(fontSize: 18);
  final TextStyle nameStyle = const TextStyle(fontSize: 20);
  final TextStyle valueStyle = const TextStyle(fontSize: 18);

  String _getValueAsString(int val, int width) {
    if (val == 0) {
      return "---";
    } else {
      return val.toString().padLeft(width, ' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelMoves =
        moves.where((element) => element.learnMethod == 'level-up').toList();
    levelMoves.sort((m1, m2) => m1.level.compareTo(m2.level));
    final machineMoves =
        moves.where((element) => element.learnMethod == 'machine').toList();
    machineMoves.sort((m1, m2) => m1.machine.compareTo(m2.machine));

    return Expanded(
        child: Card(
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      "Learnset",
                      style: titleStyle,
                    ),
                  ),
                  for (int i = 0; i < levelMoves.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(
                                      "Level",
                                      style: valueStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      _getValueAsString(levelMoves[i].level, 2),
                                      style: valueStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      levelMoves[i].name,
                                      style: nameStyle,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(levelMoves[i].flavorTextLine1,
                                        style: style),
                                    if (levelMoves[i].flavorTextLine2 != '')
                                      Text(levelMoves[i].flavorTextLine2,
                                          style: style),
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
                                    PokemonTypeTile(type: levelMoves[i].type),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    //PokemonDamageClassTypeTile(
                                    //    damageClass: levelMoves[i].damageClass)
                                  ],
                                ),
                              ),
                              Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: DataTable(
                                    headingRowHeight: 0,
                                    columns: const [
                                      DataColumn(label: Text("")),
                                      DataColumn(label: Text(""))
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text(
                                          "Accuracy",
                                          style: valueStyle,
                                        )),
                                        DataCell(SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            _getValueAsString(
                                                levelMoves[i].accuracy, 3),
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
                                            _getValueAsString(
                                                levelMoves[i].power, 3),
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
                                            _getValueAsString(
                                                levelMoves[i].pp, 3),
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
                ],
              ),
            )));
  }
}
