import 'package:flutter/material.dart';
import 'package:test_task/user_model.dart';

import 'api_provider.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  final ApiProvider apiProvider = ApiProvider();

  UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: FutureBuilder<User>(
        future: apiProvider.getUserDetails(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error getting user details'),
            );
          } else {
            final userDetails = snapshot.data;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userDetails!.avatar),
              ),
              title: Text(userDetails.name),
              subtitle: Text(userDetails.email),
            );
          }
        },
      ),
    );
  }
}
