import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/models/post.dart';
import 'package:api_flutter_laravel/api/api_service.dart';

class AdminPostsScreen extends StatefulWidget {
  @override
  _AdminPostsScreenState createState() => _AdminPostsScreenState();
}

class _AdminPostsScreenState extends State<AdminPostsScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _loadPosts();
  }

  Future<List<Post>> _loadPosts() async {
    try {
      List<Post> posts = await ApiService.getPosts();
      return posts;
    } catch (error) {
      print('Error loading posts: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
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
                  // Other post details can be added here
                );
              },
            );
          }
        },
      ),
    );
  }
}
