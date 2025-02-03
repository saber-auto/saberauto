// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin_screen.dart'; // Navigate back to admin screen
import '../data/bg_data.dart'; // Background images

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  int selectedIndex = 0; // To track selected background
  bool showOption = false;

  // List to store users fetched from Supabase
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Fetch users when the screen is initialized
  }

  // Fetch users from Supabase
  Future<void> _fetchUsers() async {
    final response = await Supabase.instance.client
        .from('users') // Assuming you have a 'users' table
        .select()
        ._execute();

    if (response.error == null) {
      setState(() {
        users = List<Map<String, dynamic>>.from(response.data);
      });
    } else {
      print("Error fetching users: ${response.error?.message}");
    }
  }

  // Delete user
  Future<void> _deleteUser(String userId) async {
    final response = await Supabase.instance.client
        .from('users') // Assuming you have a 'users' table
        .delete()
        .eq('id', userId) // Specify the user to delete
        .execute();

    if (response.error == null) {
      _fetchUsers(); // Refresh user list after deletion
    } else {
      print("Error deleting user: ${response.error?.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
              ),
              child: Column(
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/images/saber.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'User Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Admin Panel'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _buildUserManagementScreen(context),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: showOption
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: bgList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: selectedIndex == index
                                ? Colors.white
                                : Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    'assets/images/${bgList[index]}'),
                              ),
                            ),
                          ),
                        );
                      })
                  : const SizedBox(),
            ),
            const SizedBox(width: 20),
            showOption
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = true;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              'assets/images/${bgList[selectedIndex]}'),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserManagementScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/${bgList[selectedIndex]}'), // Background changeable
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          height: 400,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  'Manage Users',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user['email']),
                        subtitle: Text(user['role'] ?? 'User'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteUser(user['id']); // Delete user
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on PostgrestFilterBuilder {
  execute() {}
}

extension on PostgrestFilterBuilder<PostgrestList> {
  _execute() {}
}
