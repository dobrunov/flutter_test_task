import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_task/user_controller.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: Obx(
          () {
            if (userController.users.isEmpty && userController.isGetting.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (userController.users.isEmpty && !userController.isGetting.value) {
              return const Center(
                child: CircularProgressIndicator(), // Loading indicator
              );
            } else {
              return ListView.builder(
                //
                itemCount: userController.users.length + 1,
                itemBuilder: (context, index) {
                  final user = userController.users[index];
                  return UserCard(user: user);
                },
                //
              );
            }
          },
        ),
      ),
    );
  }
}
