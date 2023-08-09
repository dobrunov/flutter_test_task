import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/user_card.dart';
import 'package:test_task/user_controller.dart';

class HomePage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  HomePage({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        userController.loadNextPage();
      }
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          userController.loadPreviousPage();
        }
      }
    });

    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: Obx(
          () {
            if (userController.users.isEmpty && userController.isGetting.value) {
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
            } else if (userController.users.isEmpty && !userController.isGetting.value) {
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
                itemCount: userController.users.length,
                itemBuilder: (context, index) {
                  final user = userController.users[index];
                  return UserCard(user: user);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
