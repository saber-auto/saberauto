import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/bg_data.dart';
import '../utils/text_utils.dart';
import 'services_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 1;
  bool showOption = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
        _navigateToServices();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Login failed. Check your credentials.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
    setState(() => _isLoading = false);
  }

  void _navigateToServices() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ServicesScreen(
                isUserLoggedIn: true,
                selectedIndex: 1,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  backgroundImage:
                                      AssetImage('./images/${bgList[index]}'),
                                ),
                              ),
                            ),
                          );
                        })
                    : const SizedBox()),
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
                    ))
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = true;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('./images/${bgList[selectedIndex]}'),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('./images/${bgList[selectedIndex]}'),
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.center,
        child: Container(
          height: 400, // Adjusted height
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Center(
                      child: TextUtil(
                        text: "Login",
                        weight: true,
                        size: 30,
                      ),
                    ),
                    const Spacer(),
                    TextUtil(text: "Email"),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextUtil(text: "Password"),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _isLoading ? null : _login,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : TextUtil(
                                text: "Login",
                                color: Colors.black,
                              ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/register');
                        },
                        child: TextUtil(
                          text: "Don't have an account? REGISTER",
                          size: 12,
                          weight: true,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
