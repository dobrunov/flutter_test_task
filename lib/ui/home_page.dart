import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/user_controller.dart';
import '../common_widgets/load_indicator.dart';
import '../common_widgets/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController userController = Get.put(UserController());

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userController.loadUsersLocally();
    userController.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        userController.loadNextPage();
      }
    });

    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: Obx(
          () {
            if (userController.userList.isEmpty && userController.isLoading.value) {
              return const LoadIndicator();
            } else if (userController.userList.isEmpty && !userController.isLoading.value) {
              return const LoadIndicator();
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: userController.userList.length + 1,
                itemBuilder: (context, index) {
                  if (index == userController.userList.length) {
                    if (userController.isLoading.value) {
                      Future.delayed(const Duration(seconds: 1));
                      return const LoadIndicator();
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    final user = userController.userList[index];
                    return UserCard(user: user);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
