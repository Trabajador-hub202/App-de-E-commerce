import 'package:flutter/material.dart';
import 'package:la_casa_del_leon/pantallas/menu.dart';
import 'package:provider/provider.dart';
import 'package:la_casa_del_leon/modelo/cartilla.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cartilla(),
      child: MaterialApp(
        title: 'La Casa del León',
        debugShowCheckedModeBanner: false,
        home: const Menu(),
      ),
    );
  }
}
