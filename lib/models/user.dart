// D:\Documents\FlutterApp\api_flutter_laravel\lib\models\user.dart

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String birthdate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.birthdate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      birthdate: json['birthdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password,
      'birthdate': birthdate,
    };
  }
}
