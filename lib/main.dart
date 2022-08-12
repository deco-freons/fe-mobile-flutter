import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/config/route_generator.dart';
import 'package:flutter_boilerplate/example/bloc/example_bloc.dart';
import 'package:flutter_boilerplate/page/page.dart';
import 'package:flutter_boilerplate/example/data/example_repository.dart';

import 'common/config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomTheme.theme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ExampleBloc(ExampleRepositoryImpl()),
        child: Pages(),
      ),
    );
  }
}
