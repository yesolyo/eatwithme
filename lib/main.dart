
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_graduation_project/widget/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'googlelogin/login_page.dart';
import 'model/input_data.dart';
import 'pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print(FlutterConfig.get('apiKey'));
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => InputData(),
      child: LoginPage(),)

    ],

      child: MaterialApp(
          debugShowCheckedModeBanner: false,
    theme: theme(),
    home: LoginPage(),
    ),
    );
  }
}
