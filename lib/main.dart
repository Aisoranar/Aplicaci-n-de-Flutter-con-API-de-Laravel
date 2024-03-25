import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_flutter_laravel/providers/user_provider.dart';
import 'package:api_flutter_laravel/screens/login_screen.dart';
import 'package:api_flutter_laravel/screens/register_screen.dart';
import 'package:api_flutter_laravel/screens/home_screen.dart'; // Importa la pantalla HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Your App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/HomeScreen', // Cambia la ruta inicial a '/HomeScreen'
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/HomeScreen': (context) => HomeScreen(), // Agrega la ruta para HomeScreen
        },
      ),
    );
  }
}
