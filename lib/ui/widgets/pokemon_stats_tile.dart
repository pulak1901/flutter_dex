import 'package:flutter/material.dart';

class PokemonStatsTile extends StatelessWidget {
  Map<String, int> stats;
  PokemonStatsTile({Key? key, required this.stats}) : super(key: key);

  final TextStyle style = TextStyle(fontSize: 24);
  final TextStyle entryStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text('Stat', style: style)),
              DataColumn(label: Text('Value', style: style)),
            ],
            rows: stats.entries
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.key.toString(), style: entryStyle)),
                      DataCell(Text(e.value.toString(), style: entryStyle)),
                    ]))
                .toList(),
          ),
        ),
      ),
    );
  }
}
