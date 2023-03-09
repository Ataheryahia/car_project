
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String data ="";
  void fetchDate() async{
    String url = "http://127.0.0.1:8000/api/get";
    final res = await http.get(Uri.parse(url));
    var resData = json.decode(json.encode( res.body));
    debugPrint(resData);
    setState(() {
      data = resData.toString();
    });
  }
  @override
  void initState() {
    
    super.initState();
    fetchDate();
  }
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Container(child: data != '' ? Text(data):const Center(child: CircularProgressIndicator(),)),));
  }
}