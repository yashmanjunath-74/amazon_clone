import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String adress;
  final String type;
  final String token;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.adress,
      required this.type,
      required this.token});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'adress': adress,
      'type': type,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        adress: map['adress'] ?? '',
        type: map['type'] ?? '',
        token: map['token'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
