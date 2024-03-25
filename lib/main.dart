import 'package:api_flutter_laravel/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_flutter_laravel/providers/user_provider.dart';
import 'package:api_flutter_laravel/screens/login_screen.dart';
import 'package:api_flutter_laravel/screens/register_screen.dart';

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
        initialRoute: '/', // Cambia la ruta inicial a '/'
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/TabNavigator': (context) => TabNavigator(), // Agrega la ruta para el TabNavigator
        },
      ),
    );
  }
}
