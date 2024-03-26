import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/models/post.dart';
import 'package:api_flutter_laravel/api/api_service.dart';

class AdminPostsScreen extends StatefulWidget {
  @override
  _AdminPostsScreenState createState() => _AdminPostsScreenState();
}

class _AdminPostsScreenState extends State<AdminPostsScreen> {
  late Future<List<Post>> _postsFuture;
  final TextEditingController _postContentController = TextEditingController();

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

  void _deletePost(int postId) async {
    try {
      bool deleted = await ApiService.deletePost(postId);
      if (deleted) {
        setState(() {
          _postsFuture = _loadPosts(); // Recargar la lista después de eliminar la publicación
        });
      } else {
        // Manejar caso en que la eliminación falle
        // Por ejemplo, mostrar un mensaje de error o realizar alguna otra acción
        print('Error deleting post: Failed to delete post with ID $postId');
      }
    } catch (error) {
      // Manejar caso en que la eliminación falle debido a un error
      print('Error deleting post: $error');
    }
  }

  void _handlePostTap(Post post) {
    // Implementar la lógica para manejar el toque en la publicación, por ejemplo, navegar a la pantalla de detalles
    print('Tapped on post: ${post.id}');
  }

  void _addPost(String content) async {
    try {
      // Llama al método de la API para agregar una nueva publicación
      bool added = await ApiService.addPost(content);
      if (added) {
        // Si se agrega correctamente, actualizar la lista de publicaciones
        setState(() {
          _postsFuture = _loadPosts();
        });
        // Limpiar el controlador de texto después de agregar la publicación
        _postContentController.clear();
      } else {
        // Manejar caso en que la adición falle
        // Por ejemplo, mostrar un mensaje de error o realizar alguna otra acción
        print('Error adding post: Failed to add new post');
      }
    } catch (error) {
      // Manejar caso en que la adición falle debido a un error
      print('Error adding post: $error');
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
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      post.content,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Posted by: ${post.author}',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePost(post.id), // Llamar a la función para eliminar la publicación
                    ),
                    onTap: () => _handlePostTap(post), // Llamar a la función para manejar el toque en la publicación
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Mostrar un diálogo para agregar una nueva publicación
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Nueva Publicación'),
                content: TextField(
                  controller: _postContentController,
                  decoration: InputDecoration(labelText: 'Contenido'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addPost(_postContentController.text); // Llamar a la función para agregar una nueva publicación
                      Navigator.of(context).pop(); // Cerrar el diálogo después de agregar la publicación
                    },
                    child: Text('Publicar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
