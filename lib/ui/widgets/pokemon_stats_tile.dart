import 'package:flutter/material.dart';

class PokemonStatsTile extends StatelessWidget {
  final Map<String, int> stats;
  const PokemonStatsTile({Key? key, required this.stats}) : super(key: key);

  final TextStyle style = const TextStyle(
    fontSize: 24,
    fontFamily: "IBM Plex Sans",
  );
  final TextStyle entryStyle = const TextStyle(
    fontSize: 16,
    fontFamily: "IBM Plex Sans",
  );
  final TextStyle valueStyle = const TextStyle(
    fontSize: 16,
    fontFamily: "IBM Plex Mono",
  );

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
                      DataCell(Text(e.value.toString(), style: valueStyle)),
                    ]))
                .toList(),
          ),
        ),
      ),
    );
  }
}
