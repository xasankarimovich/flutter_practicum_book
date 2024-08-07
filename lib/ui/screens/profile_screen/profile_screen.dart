import 'package:buksam_flutter_practicum/utils/extension/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.grey,
              height: 200.h,
              width: 300.w,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text('Salom $index'),
                  subtitle: Text('Salom $index'),
                  trailing: Icon(Icons.access_time_outlined),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
