import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test_task/user_model.dart';
import 'package:test_task/user_detail_page.dart';

class UserCard extends StatelessWidget {
  final User user;
  final double avatarRadius;

  const UserCard({super.key, required this.user, this.avatarRadius = 65.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => UserDetailPage(user: user));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 24, right: 24),
        child: Row(
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(user.avatar),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.firstName,
                  style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5.0),
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
