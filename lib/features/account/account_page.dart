import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Container(
          padding: const EdgeInsets.only(top: 40, left: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              'https://randomuser.me/api/portraits/men/84.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(top: 40, left: 15),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'ersin@testgmail.com',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
