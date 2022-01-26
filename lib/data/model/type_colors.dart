import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/types.dart';

class TypeColors {
  static final Map<PokemonType, Color> colorOf = {
    PokemonType.placeholder1: Colors.white,
    PokemonType.normal: const Color.fromRGBO(168, 168, 120, 1),
    PokemonType.fighting: const Color.fromRGBO(192, 48, 40, 1),
    PokemonType.flying: const Color.fromRGBO(168, 144, 240, 1),
    PokemonType.poison: const Color.fromRGBO(160, 64, 160, 1),
    PokemonType.ground: const Color.fromRGBO(224, 192, 104, 1),
    PokemonType.rock: const Color.fromRGBO(184, 160, 56, 1),
    PokemonType.bug: const Color.fromRGBO(168, 184, 32, 1),
    PokemonType.ghost: const Color.fromRGBO(2112, 88, 152, 1),
    PokemonType.placeholder2: Colors.white,
    PokemonType.fire: const Color.fromRGBO(240, 128, 48, 1),
    PokemonType.water: const Color.fromRGBO(104, 144, 240, 1),
    PokemonType.grass: const Color.fromRGBO(120, 200, 80, 1),
    PokemonType.electric: const Color.fromRGBO(248, 208, 48, 1),
    PokemonType.psychic: const Color.fromRGBO(248, 88, 136, 1),
    PokemonType.ice: const Color.fromRGBO(152, 216, 216, 1),
    PokemonType.dragon: const Color.fromRGBO(112, 56, 248, 1),
  };
}
