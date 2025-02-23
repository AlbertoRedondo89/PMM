// home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'user_detail_screen.dart';
import 'add_user_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child("users");
  List<Map<String, String>> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    _database.once().then((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _users = data.entries.map((e) => {
            "name": e.value["name"].toString(),
            "email": e.value["email"].toString(),
            "address": e.value["address"].toString(),
            "phone": e.value["phone"].toString(),
            "photo": e.value["photo"].toString()
          }).toList();
        });
      }
    });
  }

  void _deleteUser(String email) {
    _database.child(email.replaceAll('.', ',')).remove();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_users[index]["name"]!),
            subtitle: Text(_users[index]["email"]!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailScreen(user: _users[index]),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteUser(_users[index]["email"]!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
        },
      ),
    );
  }
}