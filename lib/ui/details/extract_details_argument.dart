import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/ui/details/details_page.dart';

class DetailsArguments {
  final Pokemon pokemon;

  DetailsArguments(this.pokemon);
}

class ExtractDetailsArgumentPage extends StatelessWidget {
  const ExtractDetailsArgumentPage({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailsArguments;

    return Material(child: DetailsPage(pokemon: args.pokemon));
  }
}
