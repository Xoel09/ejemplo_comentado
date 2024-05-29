import 'package:exemploexamebd/forms/formulario_alta_piano.dart';
import 'package:exemploexamebd/providers/bd_provider.dart';
import 'package:exemploexamebd/providers/pianos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PianoProvider())],
      child: MyApp(),
    );
  }

  @override
  void dispose() async {
    await BdProvider.bd.closeDB();
    super.dispose();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormularioAltaPiano(),
      routes: {'alta': (_) => FormularioAltaPiano()},
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(color: Colors.indigo, elevation: 0)),
      debugShowCheckedModeBanner: false,
    );
  }
}
