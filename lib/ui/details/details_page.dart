import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';

class DetailsPage extends StatelessWidget {
  final Pokemon pokemon;
  const DetailsPage({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(pokemon.name),
    );
  }
}
