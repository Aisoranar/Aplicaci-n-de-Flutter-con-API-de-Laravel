import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/models/user.dart';
import 'package:api_flutter_laravel/api/api_service.dart';

class UserProfileScreen extends StatefulWidget {
  final String token;

  UserProfileScreen({required this.token});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUserProfile();
  }

  Future<User?> _loadUserProfile() async {
  try {
    User? user = await ApiService.getUserProfile(widget.token);
    return user;
  } catch (error) {
    print('Error loading user profile: $error');
    return null; // Devuelve null en caso de error
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Error: User data not found'));
          } else {
            User user = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ${user.id}'),
                  Text('Nombre: ${user.firstName} ${user.lastName}'),
                  Text('Nombre de usuario: ${user.username}'),
                  Text('Email: ${user.email}'),
                  Text('Fecha de nacimiento: ${user.birthdate}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
