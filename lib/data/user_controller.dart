import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/user_model.dart';

import 'api_provider.dart';

class UserController extends GetxController {
  final ApiProvider _userProvider = ApiProvider();
  var userList = <User>[].obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoading = false.obs;

  Future<void> fetchUsers() async {
    if (isLoading.value || currentPage.value > totalPages.value) return;

    isLoading.value = true;
    try {
      final response = await _userProvider.getUsers(currentPage.value);
      final userModel = ApiResponse.fromJson(jsonDecode(response.body));

      if (currentPage.value == 1) {
        totalPages.value = userModel.totalPages;
      }

      userList.addAll(userModel.data);
      currentPage.value++;

      saveUsersLocally(userList);
    } catch (error) {
      //
    } finally {
      isLoading.value = false;
    }
  }

  Future<User> fetchUserDetails(int userId) async {
    final response = await _userProvider.getUserDetails(userId);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = User.fromJson(data['data']);

      return user;
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<void> loadNextPage() async {
    await fetchUsers();
  }

  void saveUsersLocally(List<User> userList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(userList.map((user) => user.toJson()).toList());
    await prefs.setString('userList', jsonString);
  }

  Future<List<User>> loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('userList');
    if (jsonString != null) {
      final List<dynamic> data = json.decode(jsonString);
      final userList = data.map((item) => User.fromJson(item)).toList();
      return userList;
    }
    return [];
  }

  Future<void> loadUsersLocally() async {
    if (!await isInternetConnected()) {
      userList.clear();
      final localUsers = await loadFromLocal();
      userList.addAll(localUsers);
    }
  }

  Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
