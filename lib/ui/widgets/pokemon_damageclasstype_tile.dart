import 'package:flutter/material.dart';

class PokemonDamageClassTile extends StatelessWidget {
  final String damageClass;

  const PokemonDamageClassTile({Key? key, required this.damageClass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _color;
    Color _text = Colors.white;
    if (damageClass == 'Physical') {
      _color = const Color.fromRGBO(201, 33, 18, 1);
      _text = const Color.fromRGBO(246, 122, 26, 1);
    } else if (damageClass == 'Special') {
      _color = const Color.fromRGBO(79, 88, 112, 1);
    } else {
      _color = const Color.fromRGBO(140, 136, 140, 1);
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(
          damageClass,
          style: TextStyle(
              fontSize: 16,
              color: _text,
              fontFamily: "IBM Plex Sans",
              fontWeight: FontWeight.w600),
        ),
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(32), color: _color),
    );
  }
}
