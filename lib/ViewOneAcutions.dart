import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './models/auction.dart';

import 'increase.dart';

class ViewOneAcutions extends StatefulWidget {
  final Auction auction;
  const ViewOneAcutions({required this.auction, super.key});

  @override
  State<ViewOneAcutions> createState() => _ViewOneAcutionsState();
}

class _ViewOneAcutionsState extends State<ViewOneAcutions> {
  List<Map<String, dynamic>> bids = [];
  void fetchDate() async {
    String url = "http://127.0.0.1:8000/api/bidders/${widget.auction.id}";
    final res = await http.get(Uri.parse(url));
    var data = json.decode(res.body);

    data['bidders'].forEach((bidder) {
      Map<String, dynamic> bid = {};

      bid['user'] = bidder['name'];
      bid['profile_pic'] = bidder['profile_pic'];
      bid['bid_price'] = bidder['bid_price'];

      setState(() {
        bids.add(bid);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.auction.name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              context: context,
              builder: (context) {
                return increase(id: "${widget.auction.id}");
              });
        },
        child: const Icon(Icons.add_box),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(131, 158, 158, 158),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ClipRRect(
                
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Hero(
                  tag: widget.auction.id,
                  child: Row(children: [
                       Image.network(
                      'http://localhost:8000/storage/${widget.auction.image}',width:200,),
                      Column(
                        children: [
                          Text('Engine Namber : ${widget.auction.engine_namber}'),
                          Padding(padding: EdgeInsets.all(5)),
                          Text('Car Status : ${widget.auction.car_status}'),
                          
                        ],
                      ),
                  ],),
                 
                ),
              ),
            ),
            Row(
              children: [
                Text('open Price : sdg${widget.auction.price}'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.black12,
              ),
            ),
            bids.isNotEmpty
                ? Column(
                    children: [
                      ...bids.map(
                        (b) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/06ec0eec-87af-49a0-b6a1-5fc805e7e166.png'),
                                minRadius: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(b['user']),
                              ),
                              const Spacer(),
                              Text(b['bid_price'].toString())
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: Text('No bids'),
                  )
          ],
        ),
      ),
    );
  }
}
