import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:lastcard/constants.dart';
import 'package:lastcard/pages/about_us.dart';
import 'package:lastcard/pages/login_page.dart';
import 'package:lastcard/providers/authentication.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kPrimaryColor,
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: auth.authenticated
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auth.user?.phone_number.toString() ?? "User",
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            auth.user?.password ?? "",
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      )
                    : const Text(
                        "Not Logged In",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
              ListTile(
                title: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                tileColor: Colors.green,
                hoverColor: Colors.lightGreen,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'About Us',
                  style: TextStyle(color: Colors.white),
                ),
                tileColor: Colors.blue,
                hoverColor: Colors.lightBlue,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                },
              ),
              if (auth.authenticated)
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  tileColor: Colors.red,
                  hoverColor: Colors.redAccent,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              auth.logout();
                              Navigator.pop(context);
                              Future.delayed(const Duration(milliseconds: 300), () {
                                exit(0);
                              });
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}