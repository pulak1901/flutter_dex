import 'package:flutter/material.dart';

class PokemonInfoTile extends StatelessWidget {
  final String height;
  final String weight;
  final int genderRate;
  final int catchRate;
  const PokemonInfoTile(
      {Key? key,
      required this.height,
      required this.weight,
      required this.genderRate,
      required this.catchRate})
      : super(key: key);

  final TextStyle style = const TextStyle(
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
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: DataTable(headingRowHeight: 0, columns: const <DataColumn>[
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
            ], rows: [
              DataRow(cells: [
                DataCell(Text("Height", style: style)),
                DataCell(Text(height, style: valueStyle)),
              ]),
              DataRow(cells: [
                DataCell(Text("Weight", style: style)),
                DataCell(Text(weight, style: valueStyle)),
              ]),
              DataRow(cells: [
                DataCell(Text("Gender Distribution", style: style)),
                DataCell(ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LinearProgressIndicator(
                    color: Colors.blue[500],
                    backgroundColor: Colors.pink[200],
                    value: genderRate / 8,
                    minHeight: 12,
                  ),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text("Catch Rate", style: style)),
                DataCell(ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LinearProgressIndicator(
                    minHeight: 12,
                    value: catchRate / 255,
                  ),
                )),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
