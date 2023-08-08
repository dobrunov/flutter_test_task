import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_task/user_card.dart';
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
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ListView.builder(
                  //
                  itemCount: userController.users.length,
                  itemBuilder: (context, index) {
                    final user = userController.users[index];
                    return UserCard(user: user);
                  },
                  //
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
