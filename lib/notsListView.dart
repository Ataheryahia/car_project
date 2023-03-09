import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './customItem.dart';
import './models/auction.dart';

class notListView extends StatefulWidget {
  const notListView({super.key});

  @override
  State<notListView> createState() => _notListViewState();
}

class _notListViewState extends State<notListView> {
  List<Auction> auctions = [];
  void fetchDate() async {
    String url = "http://127.0.0.1:8000/api/get";
    final res = await http.get(Uri.parse(url));
    var data = json.decode(res.body);
    data['auctions'].forEach((auc) {
      Auction auction = Auction(
          id: auc['id'],
          name: auc['car_name'],
          image: auc['image'],
          car_model: auc['car_model'],
          c_name: auc['c_name'],
          car_color: auc['car_color'],
          car_status: auc['car_status'],
          engine_namber: auc['engine_namber'],
          price: auc['price'],
          created: auc['created'],
          end_Date: auc['end_Date']);

          setState(() {
          auctions.add(auction);
          });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDate();
  }

  @override
  Widget build(BuildContext context) {
    return auctions.isEmpty ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
            itemCount: auctions.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(top: 10), child: notItem(auction: auctions[index],));
            });
  }
}
