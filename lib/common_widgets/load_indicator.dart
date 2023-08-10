import 'package:flutter/material.dart';

class LoadIndicator extends StatelessWidget {
  const LoadIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.green,
      strokeWidth: 10.0,
    ));
  }
}
