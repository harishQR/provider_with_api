import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_api/providers/pets_provider.dart';
import 'home.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) => petsProvider() ,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
    ),
    );
  }
}

