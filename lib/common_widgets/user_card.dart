import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/size_styles.dart';
import '../constants/text_styles.dart';
import '../domain/user_model.dart';
import '../ui/user_detail_page.dart';

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
            SizeStyle.sizedBoxWidth10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.firstName,
                  style: TextStyles.nameTextStyle22Black,
                ),
                SizeStyle.sizedBoxHeight5,
                Text(
                  user.email,
                  style: TextStyles.emailTextStyle16Grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
