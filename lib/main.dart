
import 'package:ficha_bda/widget_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  // Definindo a orientação em pé do celular por padrão
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const WidgetApp());
}