import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseUrl = "https://reqres.in/api/users";

  Future<http.Response> getUsers(int page) async {
    final response = await http.get(Uri.parse("$baseUrl?page=$page"));
    return response;
  }

  Future<http.Response> getUserDetails(int userId) async {
    final response = await http.get(Uri.parse("$baseUrl/$userId"));
    return response;
  }
}
