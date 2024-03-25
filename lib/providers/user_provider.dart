import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/models/user.dart';
import 'package:api_flutter_laravel/api/api_service.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> fetchUsers() async {
    try {
      List<User> fetchedUsers = await ApiService.getUsers();
      _users = fetchedUsers;
      notifyListeners();
    } catch (error) {
      print('Error al cargar los usuarios: $error');
    }
  }

  Future<void> addUser(User newUser) async {
    try {
      bool added = await ApiService.addUser(newUser);
      if (added) {
        _users.add(newUser);
        notifyListeners();
      }
    } catch (error) {
      print('Error al agregar el usuario: $error');
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      bool deleted = await ApiService.deleteUser(userId);
      if (deleted) {
        _users.removeWhere((user) => user.id == userId);
        notifyListeners();
      }
    } catch (error) {
      print('Error al eliminar el usuario: $error');
    }
  }
}
