import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/api/api_service.dart';
import 'package:api_flutter_laravel/token_storage.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      
      String? token = await ApiService.login(email, password);
      
      if (token != null) {
        await TokenStorage().saveToken(token);
        
        // Llama a _checkToken después de guardar el token
        _checkToken(token); // Pasar el token como argumento
        
        Navigator.pushReplacementNamed(context, '/TabNavigator');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  // Función para verificar el token
  void _checkToken(String token) async {
    print('Token almacenado después del inicio de sesión: $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
