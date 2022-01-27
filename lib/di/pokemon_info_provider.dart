import 'package:flutter_dex/data/model/pokemon_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pokemon_repository_provider.dart';

final pokemonInfoProvider = FutureProvider.family<PokemonInfo, int>(
    (ref, id) => ref.read(pokemonRepositoryProvider).getPokemonInfo(id));
