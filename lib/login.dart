import 'package:flutter/material.dart';
import './bainaryColor.dart';
import './customButton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }

  final _user_name = TextEditingController();
  final _password = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _user_name.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Container(
          child: Column(
        children: [
          const CircleAvatar(
            backgroundImage:
                AssetImage('assets/Screenshot from 2022-07-24 11-36-15.png'),
            minRadius: 50,
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
              cursorColor: KeyBainaryColor,
              controller: _user_name,
              decoration: InputDecoration(
                  hintText: 'UserName',
                  border: buildBorder(),
                  focusColor: KeyBainaryColor1,
                  enabledBorder: buildBorder(KeyBainaryColor))),
          const SizedBox(
            height: 16,
          ),
          TextField(
              cursorColor: KeyBainaryColor,
              controller: _password,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: buildBorder(),
                  focusColor: KeyBainaryColor,
                  enabledBorder: buildBorder(Colors.blue))),
          const SizedBox(
            height: 16,
          ),
          customButton(),
        ],
      )),
    );
  }
}
