import 'package:flutter/material.dart';

import '../constants/size_styles.dart';
import '../constants/text_styles.dart';
import '../domain/user_model.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
    required this.userDetails,
  });

  final User? userDetails;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20),
            child: CircleAvatar(
              radius: 120.0,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(userDetails!.avatar),
            ),
          ),
          Text(
            "${userDetails?.firstName} ${userDetails?.lastName}",
            style: TextStyles.profileNameTextStyle28Black,
          ),
          SizeStyle.sizedBoxHeight5,
          Text(
            userDetails!.email,
            style: TextStyles.emailTextStyle16Grey,
          ),
          SizeStyle.sizedBoxHeight5,
          Text(
            'id: ${userDetails?.id.toString()}',
            style: TextStyles.emailTextStyle16Grey,
          ),
        ],
      ),
    );
  }
}
