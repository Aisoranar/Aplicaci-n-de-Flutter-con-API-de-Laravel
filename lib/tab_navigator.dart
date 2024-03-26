import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/screens/user_profile_screen.dart';
import 'package:api_flutter_laravel/screens/user_posts_screen.dart';
import 'package:api_flutter_laravel/screens/admin_users_screen.dart';
import 'package:api_flutter_laravel/screens/admin_posts_screen.dart';

class TabNavigator extends StatelessWidget {
  final String token;

  TabNavigator({required this.token});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Navigator'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Perfil'),
              Tab(text: 'Posts'),
              Tab(text: 'Usuarios (Admin)'),
              Tab(text: 'Posts (Admin)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserProfileScreen(token: token),
            UserPostsScreen(),
            AdminUsersScreen(),
            AdminPostsScreen(),
          ],
        ),
      ),
    );
  }
}
