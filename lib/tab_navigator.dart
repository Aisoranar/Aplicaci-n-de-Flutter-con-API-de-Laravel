import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/screens/user_profile_screen.dart';
import 'package:api_flutter_laravel/screens/user_posts_screen.dart';
import 'package:api_flutter_laravel/screens/admin_users_screen.dart';
import 'package:api_flutter_laravel/screens/admin_posts_screen.dart';

class TabNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Número total de pestañas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Navigator'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Perfil'), // Pestaña para el perfil del usuario
              Tab(text: 'Posts'), // Pestaña para los posts del usuario
              Tab(text: 'Usuarios (Admin)'), // Pestaña para la lista de usuarios (solo para administradores)
              Tab(text: 'Posts (Admin)'), // Pestaña para la lista de posts (solo para administradores)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserProfileScreen(), // Contenido de la pestaña de perfil del usuario
            UserPostsScreen(), // Contenido de la pestaña de posts del usuario
            AdminUsersScreen(), // Contenido de la pestaña de lista de usuarios (solo para administradores)
            AdminPostsScreen(), // Contenido de la pestaña de lista de posts (solo para administradores)
          ],
        ),
      ),
    );
  }
}
