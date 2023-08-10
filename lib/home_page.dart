import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/user_card.dart';
import 'package:test_task/user_controller.dart';

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
              return const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 10.0,
                  ),
                ),
              );
            } else if (userController.userList.isEmpty && !userController.isLoading.value) {
              return const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 10.0,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: userController.userList.length + 1, // Add 1 for the loading indicator
                itemBuilder: (context, index) {
                  if (index == userController.userList.length) {
                    // Show a loading indicator at the end of the list for pagination
                    if (userController.isLoading.value) {
                      Future.delayed(const Duration(seconds: 1), () {});
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.green,
                        strokeWidth: 10.0,
                      ));
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
