class User {
  final int id;
  String firstName; // Quitamos la palabra clave final
  String lastName; // Quitamos la palabra clave final
  String username;
  String email; // Quitamos la palabra clave final
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
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      birthdate: json['birthdate'] ?? '',
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
