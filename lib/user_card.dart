import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test_task/user_model.dart';
import 'package:test_task/user_detail_page.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Card(
        child: InkWell(
          onTap: () {
            Get.to(UserDetailPage(user: user));
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(user.avatar),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(user.email),
            ),
          ),
        ),
      ),
    );
  }
}
