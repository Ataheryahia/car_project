import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/user.dart';
import './viewAllAcutions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  final _nameInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _phoneInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _imageInputController = TextEditingController();
  final _addresInputController = TextEditingController();

  bool _showALert = false;
  bool _isLoading = false;
  Future<http.Response> submitRequesterForm(String name,String phone,String email,String pass,String address) {
    return http.post(
      Uri.parse('http://127.0.0.1:8000/api/requester'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phone': phone,
        'email':email,
        'pass':pass,
        'address':address,
      }),
    );
  }

  void reqester(context) async {
    setState(() {
      _isLoading = true;
    });

    String name = _nameInputController.text;
    String phone = _phoneInputController.text;
    String email = _emailInputController.text;
    String pass = _passwordInputController.text;
    
    String address = _addresInputController.text;

    if (name == '' || pass == '' || email == '') {
      print("ALL FIELDS ARE REQUIRED TO LOGIN !");
      return;
    }

    final response = await submitRequesterForm(name,phone,email,pass,address);
    var data = json.decode(response.body);
    debugPrint(response.body);

    setState(() {
      _isLoading = false;
    });
    
    if(!data['status']) {
      setState(() {
        _showALert = true;
      });
    } else {
      _isLoading = false;
      User.setUserData(data['user']['id'], data['user']['name'],data['user']['email']);
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const viewAllAcutions() ));
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _showALert
                  ? Dialog(
                      backgroundColor: Colors.red[200],
                      insetPadding: EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red[700],
                            ),
                            const Text("Wrong username or password")
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: size.height * 0.05,
              ),
              // SvgPicture.asset("assets/SVG/pied-piper-alt.svg", color: Theme.of(context).primaryColor, width: 120 , height: 120,),
              const Text(
                "Welcome !",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text(
                "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Adipisci ratione .",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                    letterSpacing: 0),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              TextField(
                onTap: () {
                  setState(() {
                    _showALert = false;
                  });
                },
                controller: _nameInputController,
                decoration: InputDecoration(
                    label: Text("Name",
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    prefixIcon: Icon(Icons.person,
                        color: Theme.of(context).primaryColor),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                    // border: InputBorder.none
                    ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              TextField(
                onTap: () {
                  setState(() {
                    _showALert = false;
                  });
                },
                controller: _emailInputController,
                decoration: InputDecoration(
                    hintText: "email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20)),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              TextField(
                onTap: () {
                  setState(() {
                    _showALert = false;
                  });
                },
               
                controller: _phoneInputController,
                decoration: InputDecoration(
                    hintText: "phone",
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Theme.of(context).primaryColor,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20)),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
         TextField(
                onTap: () {
                  setState(() {
                    _showALert = false;
                  });
                },
                obscureText: true,
                controller: _passwordInputController,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20)),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                TextField(
                onTap: () {
                  setState(() {
                    _showALert = false;
                  });
                },
                
                controller: _addresInputController,
                decoration: InputDecoration(
                    hintText: "address",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20)),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                  width: size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      reqester(context);
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "sign up",
                            style: TextStyle(fontSize: 20, letterSpacing: 1),
                          ),
                  )),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            
            ],
          ),
        ),
      ),
    );
  }
}
