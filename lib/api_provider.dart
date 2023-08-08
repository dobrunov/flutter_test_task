import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:test_task/user_model.dart';

class ApiProvider {
  final String baseUrl = "https://reqres.in/api/users";

  Future<List<User>> getUsers({int page = 1}) async {
    final response = await http.get(Uri.parse("$baseUrl?page=$page"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final users = List.from(data['data']).map((user) {
        return User.fromJson(user);
      }).toList();

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserDetails(int userId) async {
    final response = await http.get(Uri.parse("$baseUrl/$userId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = User.fromJson(data['data']);

      return user;
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
