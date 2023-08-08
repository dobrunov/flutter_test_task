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
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(userDetails!.avatar),
                    ),
                  ),
                  Text(
                    userDetails.name,
                    style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    userDetails.email,
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'id: ${userDetails.id.toString()}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
