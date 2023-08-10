import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/user_controller.dart';
import '../domain/user_model.dart';
import '../constants/string_constants.dart';

import '../common_widgets/load_indicator.dart';
import '../common_widgets/user_profile.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  final UserController userController = Get.put(UserController());

  UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.userDetails),
        ),
        body: FutureBuilder<User>(
          future: userController.fetchUserDetails(user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadIndicator();
              //
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(StringConstants.errorGetDetails),
              );
              //
            } else {
              final userDetails = snapshot.data;
              return UserProfileWidget(userDetails: userDetails);
            }
          },
        ),
      ),
    );
  }
}
