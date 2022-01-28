import 'package:flutter_dex/data/model/types.dart';
import 'package:flutter_dex/utility/string_extension.dart';

class PokemonMove {
  final int level;
  final String learnMethod;
  final int accuracy;
  final int power;
  final int pp;
  final String name;
  final String flavorTextLine1;
  final String flavorTextLine2;
  final PokemonType type;
  final String machine;
  final String damageClass;

  PokemonMove(
      {required this.level,
      required this.learnMethod,
      required this.accuracy,
      required this.power,
      required this.pp,
      required this.name,
      required this.flavorTextLine1,
      required this.flavorTextLine2,
      required this.type,
      required this.machine,
      required this.damageClass});

  static List<List<PokemonMove>> fromQuery(Map<String, dynamic> data) {
    List<PokemonMove> moves = [];

    List<dynamic> ms = data["pokemon_v2_pokemonmove"];

    for (int i = 0; i < ms.length; i++) {
      int _level = 0;
      String _learnMethod = "";
      String _name = "";
      int _power = 0;
      int _pp = 0;
      int _accuracy = 0;
      String _machine = "";
      String _flavorTextL1 = "";
      String _flavorTextL2 = "";
      int _type = 0;
      String _damageClass = "";

      Map<String, dynamic> m1 = ms[i];
      _level = m1["level"];

      Map<String, dynamic> m2 = m1["pokemon_v2_move"];
      _name = m2["name"];
      _name = _name.split('-').map((e) => e.capitalize()).join(" ");
      if (m2["power"] != null) {
        _power = m2["power"];
      }
      if (m2["pp"] != null) {
        _pp = m2["pp"];
      }
      if (m2["accuracy"] != null) {
        _accuracy = m2["accuracy"];
      }
      _type = m2["type_id"];

      List<dynamic> m3 = m2["pokemon_v2_machines"];
      if (m3.isNotEmpty) {
        Map<String, dynamic> m31 = m3.first;
        Map<String, dynamic> m32 = m31["pokemon_v2_item"];
        _machine = m32["name"];
        _machine = _machine.toUpperCase();
      }

      Map<String, dynamic> m4 = m2["pokemon_v2_movedamageclass"];
      List<dynamic> m41 = m4["pokemon_v2_movedamageclassnames"];
      Map<String, dynamic> m42 = m41.first;
      _damageClass = m42["name"];
      _damageClass = _damageClass.capitalize();

      List<dynamic> m5 = m2["pokemon_v2_moveflavortexts"];
      Map<String, dynamic> m51 = m5[0];
      String _flavorText = m51["flavor_text"];
      _flavorText = _flavorText.replaceAll('\f', '').replaceAll('­', '-');
      final _ft = _flavorText.split('\n');
      _flavorTextL1 = _ft.first;
      if (_ft.length > 1) {
        _flavorTextL2 = _ft.last;
      }

      Map<String, dynamic> m6 = m1["pokemon_v2_movelearnmethod"];
      _learnMethod = m6["name"];

      moves.add(PokemonMove(
          level: _level,
          learnMethod: _learnMethod,
          accuracy: _accuracy,
          power: _power,
          pp: _pp,
          name: _name,
          flavorTextLine1: _flavorTextL1,
          flavorTextLine2: _flavorTextL2,
          type: PokemonType.values[_type],
          damageClass: _damageClass,
          machine: _machine));
    }

    final _levelUp = moves.where((e) => e.learnMethod == 'level-up').toList();
    final _hm = moves
        .where((e) => e.learnMethod == 'machine' && e.machine.startsWith('HM'))
        .toList();
    _hm.sort((m1, m2) => m1.machine.compareTo(m2.machine));
    final _tm = moves
        .where((e) => e.learnMethod == 'machine' && e.machine.startsWith('TM'))
        .toList();
    _tm.sort((m1, m2) => m1.machine.compareTo(m2.machine));

    return [_levelUp, _hm, _tm];
  }
}
