import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/user_model.dart';

import 'api_provider.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var currentPage = 1.obs;
  var isGetting = false.obs;
  late int pagesQuantity;
  var pages = <List<User>>[];

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    isGetting.value = true;
    try {
      final apiProvider = ApiProvider();
      pagesQuantity = await apiProvider.getPagesQuantity();
      final userList = await apiProvider.getUsers(page: currentPage.value);
      users.value = userList;
      saveToLocal(userList);

      pages.add(userList);
    } catch (e) {
      users.value = await loadFromLocal();
    }
    isGetting.value = false;
  }

  Future<void> loadNextPage() async {
    if (isGetting.value) return; // Prevent duplicate requests
    if (currentPage < pagesQuantity) {
      currentPage.value++;
      await getUsers();
    }
  }

  Future<void> loadPreviousPage() async {
    if (isGetting.value) return; // Prevent duplicate requests
    if (currentPage.value > 1) {
      currentPage.value--;
      if (currentPage.value <= pages.length) {
        users.value = pages[currentPage.value - 1];
      } else {
        await getUsers();
      }
    }
  }

  void saveToLocal(List<User> userList) async {
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
}
