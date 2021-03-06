import 'package:flutter/material.dart';
import 'package:flutter_dex/ui/details/extract_details_argument.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/home/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => const HomePage(),
        '/details': (_) => const ExtractDetailsArgumentPage(),
      },
    );
  }
}
