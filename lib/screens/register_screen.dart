import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/models/user.dart';
import 'package:api_flutter_laravel/api/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late DateTime _selectedDate = DateTime.now();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        id: 0,
        firstName: _firstNameController.text, // Asegúrate de que firstName no sea nulo
        lastName: _lastNameController.text, // Asegúrate de que lastName no sea nulo
        birthdate: _selectedDate.toIso8601String(),
        username: _usernameController.text, // Asegúrate de que username no sea nulo
        email: _emailController.text, // Asegúrate de que email no sea nulo
        password: _passwordController.text, // Asegúrate de que password no sea nulo
      );

      ApiService.register(
        newUser.firstName,
        newUser.lastName,
        newUser.birthdate,
        newUser.username,
        newUser.email,
        newUser.password,
      ).then((response) {
        if (response) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuario registrado exitosamente'),
            ),
          );
          Navigator.pushNamed(context, '/HomeScreen');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al registrar al usuario'),
            ),
          );
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Nombres'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tus nombres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tus apellidos';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(
                  'Fecha de Nacimiento',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                subtitle: Text(
                  '${_selectedDate.toLocal()}'.split(' ')[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nombre de Usuario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre de usuario';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor confirma tu contraseña';
                  }
                  if (value != _passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
