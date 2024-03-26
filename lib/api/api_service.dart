import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_flutter_laravel/models/post.dart';
import 'package:api_flutter_laravel/models/user.dart';

class ApiService {
  static final String baseUrl = 'http://192.168.0.25:8000/api';

  // Métodos para el controlador de administración de API

  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/admin/users'));

    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body)['users'];
      return List<User>.from(data.map((user) => User.fromJson(user)));
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/admin/users/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = json.decode(response.body);
      return User.fromJson(userData['user']);
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<bool> editUser(int userId, String firstName, String lastName, String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/admin/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deleteUser(int userId) async {
    final response = await http.delete(Uri.parse('$baseUrl/admin/users/$userId'));

    return response.statusCode == 200;
  }

  static Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/admin/posts'));

    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body)['posts'];
      return List<Post>.from(data.map((post) => Post.fromJson(post)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<Post> getPostById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/admin/posts/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> postData = json.decode(response.body);
      return Post.fromJson(postData['post']);
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<bool> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/admin/posts/$postId'));

    return response.statusCode == 200;
  }

  static Future<bool> addPost(String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'content': content}),
    );

    return response.statusCode == 201;
  }

  // Métodos para el controlador de usuario de la API

  static Future<User?> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = json.decode(response.body);
      if (userData.containsKey('user') && userData['user'] != null) {
        return User.fromJson(userData['user']);
      } else {
        print('User data not found in response');
        return null;
      }
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  static Future<List<Post>> getUserPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user/posts'));

      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['posts'];
        return List<Post>.from(data.map((post) => Post.fromJson(post)));
      } else {
        throw Exception('Failed to load user posts: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error loading user posts: $error');
      throw Exception('Failed to load user posts');
    }
  }

  static Future<bool> register(
    String firstName,
    String lastName,
    String birthdate,
    String username,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'birthdate': birthdate,
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );

    return response.statusCode == 201;
  }

  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['token'];
    } else {
      return null;
    }
  }

  static Future<bool> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (error) {
      print('Error logging out: $error');
      return false;
    }
  }

  static Future<bool> addUser(User newUser) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newUser.toJson()),
    );

    return response.statusCode == 201;
  }
}
