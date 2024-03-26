import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_flutter_laravel/providers/user_provider.dart';
import 'package:api_flutter_laravel/screens/login_screen.dart';
import 'package:api_flutter_laravel/screens/register_screen.dart';
import 'package:api_flutter_laravel/token_storage.dart'; // Importa la clase TokenStorage
import 'package:api_flutter_laravel/tab_navigator.dart';

void main() {
  runApp(MyApp());
  _checkToken(); // Llama a la función para verificar el token al iniciar la aplicación
}

void _checkToken() async {
  String? token = await TokenStorage().readToken();
  print('Token almacenado: $token');
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
          '/TabNavigator': (context) => TabNavigator(token: ''), // Agrega la ruta para el TabNavigator con un token vacío
        },
      ),
    );
  }
}
