import 'package:car_app/customButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './models/user.dart';
import './viewAllAcutions.dart';

import './bainaryColor.dart';

class increase extends StatefulWidget {
  final String id ;
  increase({super.key,required this.id});
  
  @override
  State<increase> createState() => _increaseState();
}

class _increaseState extends State<increase> {
 final _bidPriceController = TextEditingController();
  
  bool _isLoading = false;

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }

  void makeBid() async {
    
    setState(() {
      _isLoading = true;
    });

    String price = _bidPriceController.text;

    if(price == '') {
      print("");
      return;
    }
    
  Future<http.Response> add_biders(String bid_price,String auction_id,String user_id) {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/api/add_bid'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
    'bid_price': price,
    'auction_id':widget.id,
    'user_id':User.getUserId().toString(),
    }),
  );
}

var response = await add_biders(price , widget.id , User.getUserId().toString());
var data = json.decode(response.body);
  // debugPrint(response.body);

    setState(() {
      _isLoading = false;
    });

    if(!data['status']) {
      setState(() {
        // _showALert = true;
      });
    } else {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const viewAllAcutions() ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        child: Column(children:  [
          TextField(
              cursorColor: KeyBainaryColor,
              controller: _bidPriceController,
              decoration: InputDecoration(
                  hintText: 'Your Price',
                  border: buildBorder(),
                  focusColor: KeyBainaryColor1,
                  enabledBorder: buildBorder(KeyBainaryColor))),
          const Spacer(),
           Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: makeBid,
                  // splashColor: Theme.of(context).primaryColor,
                  // color: Theme.of(context).primaryColor,
                  // textColor: Colors.white,
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text("Bid" , style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1
                  ),) ,
                )
              ) ,
          )
        ]),
      ),
    ));
  }
}
