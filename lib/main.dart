import 'package:etiquette/app/App.dart';
import 'package:etiquette/app/app_initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = await AppInitializer.initialize();
  runApp(App(dio));
}
