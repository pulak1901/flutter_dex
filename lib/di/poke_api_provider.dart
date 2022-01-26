import 'package:flutter_dex/data/api/poke_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokeApiProvider =
    Provider((ref) => PokeApiClient("https://beta.pokeapi.co/graphql/v1beta"));
