
import 'package:car_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';


class Myhome extends StatelessWidget {
  
  const Myhome({super.key});
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Padding(padding: const EdgeInsets.symmetric(vertical: 20),child: LoginScreen(),)
    );
    
  }
}
