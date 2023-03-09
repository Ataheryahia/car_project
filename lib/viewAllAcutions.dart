import 'package:flutter/material.dart';
import 'package:car_app/notsListView.dart';
import './models/user.dart';

class viewAllAcutions extends StatelessWidget {
  const viewAllAcutions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Welcome ${User.getUserName()}'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Expanded(
          child: notListView(),
        ),
      ),
    );
  }
}
