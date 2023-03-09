import 'package:car_app/customItem.dart';
import 'package:car_app/my_home.dart';
import 'package:flutter/material.dart';
import './bainaryColor.dart';
import './viewAllAcutions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class customButton extends StatelessWidget {
 
  const customButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return const viewAllAcutions();
        }));
      },
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color:KeyBainaryColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: const Center(
        child: Text('login',style:TextStyle(color: Color.fromARGB(255, 255, 249, 249))),
      ),
      
    ),
    
    );
   
     }
}
