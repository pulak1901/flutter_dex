import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/type_colors.dart';
import 'package:flutter_dex/data/model/types.dart';
import 'package:flutter_dex/utility/string_extension.dart';

class PokemonTypeTile extends StatelessWidget {
  final PokemonType type;

  const PokemonTypeTile({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(
          type.name.capitalize(),
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: TypeColors.colorOf[type]),
    );
  }
}