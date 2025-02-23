import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final Map<String, String> user;
  
  UserDetailScreen({required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user["name"]!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(user["photo"]!),
            Text("Email: ${user["email"]}"),
            Text("Address: ${user["address"]}"),
            Text("Phone: ${user["phone"]}"),
          ],
        ),
      ),
    );
  }
}