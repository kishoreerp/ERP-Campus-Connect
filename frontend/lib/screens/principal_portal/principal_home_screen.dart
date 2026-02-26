import 'package:flutter/material.dart';

class PrincipalHomeScreen extends StatelessWidget {
  final String username;

  const PrincipalHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Principal Home"),
      ),
      body: Center(
        child: Text(
          "Welcome, $username",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}