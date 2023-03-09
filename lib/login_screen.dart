import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './viewAllAcutions.dart';
import './RegisterScreen.dart';
import './models/user.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Map<String , String>> users = [];

  final _nameInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  bool _showALert = false;
  bool _isLoading = false;

  Future<http.Response> submitLoginForm(String name , String password) {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'pass': password,
    }),
  );
}

  void login(context) async{
    setState(() {
      _isLoading = true;
    });

    String name = _nameInputController.text;
    String password = _passwordInputController.text;

    if(name == '' || password == '') {
      print("ALL FIELDS ARE REQUIRED TO LOGIN !");
      return;
    }
    
    final response = await submitLoginForm(name, password);
    var data = json.decode(response.body);
    print(response.body);

    setState(() {
      _isLoading = false;
    });

    if(!data['status']) {
      setState(() {
        _showALert = true;
      });
    } else {

      User.setUserData(data['user']['id'], data['user']['name'], data['user']['email']);

      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const viewAllAcutions() ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ListView(
            children: [
              _showALert ? Dialog(
                backgroundColor: Colors.red[200],
                insetPadding: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Icon(Icons.error , color: Colors.red[700],) ,
                      const Text("Wrong username or password")
                    ],
                  ),
                ),
              ) : const SizedBox(height: 0,),
              SizedBox(height: size.height * 0.05,),
              // SvgPicture.asset("assets/SVG/pied-piper-alt.svg", color: Theme.of(context).primaryColor, width: 120 , height: 120,),
              const Text("Welcome !",
                style: TextStyle(
                  color: Colors.black87 ,
                  fontSize: 35 ,
                  fontWeight: FontWeight.w500 ,
                  letterSpacing: 0
                ),
                textAlign: TextAlign.center,
              ) ,
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text("Lorem ipsum dolor sit amet consectetur, adipisicing elit. Adipisci ratione ." ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600] ,
                  fontSize: 14 ,
                  fontWeight: FontWeight.w500 ,
                  fontFamily: "Roboto" ,
                  letterSpacing: 0
                ),
              ) ,
              const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              TextField(
                onTap: () {
                  setState(() {
                    _showALert = false;
                  });
                },
                controller: _nameInputController,
                decoration: InputDecoration(
                  label: Text("Name" , style: TextStyle(
                    color: Colors.grey[700] ,
                  )),
                  prefixIcon: Icon(CupertinoIcons.person , color: Theme.of(context).primaryColor),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey ,
                      width: 1 ,
                    ) ,
                    borderRadius: BorderRadius.circular(7)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue ,
                        width: 1 ,
                      ) ,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20)
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
                obscureText: true,
                controller: _passwordInputController,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(CupertinoIcons.lock , color: Theme.of(context).primaryColor,),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey ,
                          width: 1 ,
                        ) ,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color:  Colors.blue ,
                          width: 1 ,
                        ) ,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20)
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                width: size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    login(context);
                  },
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text("Sign in" , style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1
                  ),) ,
                )
              ) ,
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("dont have an account ? " ,style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                  TextButton(
                    child: Text("sign up" ,
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18), textAlign: TextAlign.end,) ,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const RegisterScreen() ));
                      }
                  ),
                ],
              ) ,
            ],
          ),
        ),
      ),
    );
  }
}
