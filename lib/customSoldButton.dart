
import 'package:car_app/viewAllAcutions.dart';
import 'package:flutter/material.dart';
import './bainaryColor.dart';

class customSoldButton extends StatelessWidget {
  const customSoldButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
            return const viewAllAcutions();
        }));
      },
      child:  Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color:KeyBainaryColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: const Center(
        child: Text('Buy',style:TextStyle(color: Color.fromARGB(255, 255, 249, 249))),
      ),
    ),
    );
   
  }
}