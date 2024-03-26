import 'package:flutter/material.dart';
import 'package:api_flutter_laravel/api/api_service.dart';
import 'package:api_flutter_laravel/models/user.dart';

class AdminUsersScreen extends StatefulWidget {
  @override
  _AdminUsersScreenState createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _loadUsers();
  }

  Future<List<User>> _loadUsers() async {
    try {
      List<User> users = await ApiService.getUsers();
      return users;
    } catch (error) {
      print('Error loading users: $error');
      throw error;
    }
  }

  void _editUser(User user) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Usuario'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: user.firstName),
                decoration: InputDecoration(labelText: 'Nombre'),
                onChanged: (value) => user.firstName = value,
              ),
              TextField(
                controller: TextEditingController(text: user.lastName),
                decoration: InputDecoration(labelText: 'Apellido'),
                onChanged: (value) => user.lastName = value,
              ),
              TextField(
                controller: TextEditingController(text: user.email),
                decoration: InputDecoration(labelText: 'Correo electrónico'),
                onChanged: (value) => user.email = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              bool success = await _saveEditedUser(user); // Llama a la función para guardar los cambios
              Navigator.pop(context, success);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );

    if (result != null && result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuario actualizado')));
      setState(() {
        _usersFuture = _loadUsers();
      });
    }
  }

  Future<bool> _saveEditedUser(User user) async {
    try {
      // Llama al método de la API para editar el usuario con los datos actualizados
      await ApiService.editUser(user.id, user.firstName, user.lastName, user.email);
      return true; // Indica que la operación fue exitosa
    } catch (error) {
      print('Error saving edited user: $error');
      return false; // Indica que la operación falló
    }
  }

  void _deleteUser(User user) async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Usuario'),
        content: Text('¿Está seguro de que desea eliminar este usuario?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              bool success = await ApiService.deleteUser(user.id);
              Navigator.pop(context, success);
            },
            child: Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != null && confirmed) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuario eliminado')));
      setState(() {
        _usersFuture = _loadUsers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<User> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      user.email,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue), // Icono de editar en azul
                          onPressed: () => _editUser(user),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red), // Icono de eliminar en rojo
                          onPressed: () => _deleteUser(user),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
