import 'dart:ui';
import 'package:flutter/material.dart';
import 'movie_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isHovering = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1f1c2c), Color(0xFF928DAB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// GLOW
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// CONTENT
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_movies,
                              size: 70, color: Colors.white),

                          const SizedBox(height: 10),

                          const Text(
                            "XIII Cinema",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Masuk dan nikmati film favoritmu 🍿",
                            style: TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 25),

                          /// USERNAME
                          TextField(
                            controller: _usernameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.white),
                              hintText: "Username",
                              hintStyle:
                                  const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          /// PASSWORD
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.white),
                              hintText: "Password",
                              hintStyle:
                                  const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          /// 🔥 BUTTON HOVER + PRESS
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) =>
                                setState(() => isHovering = true),
                            onExit: (_) => setState(() {
                              isHovering = false;
                              isPressed = false;
                            }),
                            child: GestureDetector(
                              onTapDown: (_) =>
                                  setState(() => isPressed = true),
                              onTapUp: (_) =>
                                  setState(() => isPressed = false),
                              onTapCancel: () =>
                                  setState(() => isPressed = false),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MovieListPage(
                                      username:
                                          _usernameController.text,
                                    ),
                                  ),
                                );
                              },
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 180),
                                width: double.infinity,
                                height: 55,
                                transform: Matrix4.identity()
                                  ..scale(
                                    isPressed
                                        ? 0.97
                                        : isHovering
                                            ? 1.06
                                            : 1.0,
                                  ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: isHovering
                                        ? [Colors.pink, Colors.deepPurple]
                                        : [Colors.purple, Colors.blue],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (isHovering
                                              ? Colors.pink
                                              : Colors.purple)
                                          .withOpacity(0.6),
                                      blurRadius:
                                          isHovering ? 30 : 15,
                                      offset: const Offset(0, 6),
                                    )
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Belum punya akun? Daftar",
                              style: TextStyle(color: Colors.white70),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}