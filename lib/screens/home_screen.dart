import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/api/api_service.dart'; 

class HomeScreen extends StatelessWidget {
  void _logout(BuildContext context) async {
    bool loggedOut = await ApiService.logout();
    
    if (loggedOut) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // Cambia la ruta a '/login'
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión. Por favor, inténtalo de nuevo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido a la pantalla de inicio',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
