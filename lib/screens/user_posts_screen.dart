import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/models/post.dart';
import 'package:api_flutter_laravel/api/api_service.dart';

class UserPostsScreen extends StatefulWidget {
  @override
  _UserPostsScreenState createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  late Future<List<Post>> _userPostsFuture;

  @override
  void initState() {
    super.initState();
    _userPostsFuture = _loadUserPosts();
  }

  Future<List<Post>> _loadUserPosts() async {
    try {
      List<Post> posts = await ApiService.getUserPosts();
      return posts;
    } catch (error) {
      print('Error loading user posts: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _userPostsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Post> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.content),
                  // Otros detalles del post
                );
              },
            );
          }
        },
      ),
    );
  }
}
