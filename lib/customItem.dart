import 'package:flutter/material.dart';
import './ViewOneAcutions.dart';
import './models/auction.dart';

class notItem extends StatefulWidget {
  final Auction auction;
  notItem({required this.auction});
  @override
  State<notItem> createState() => _notItemState();
}

class _notItemState extends State<notItem> {
  
  @override
  Widget build(BuildContext context) {
    // return Text(widget.auction.name);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ViewOneAcutions(auction: widget.auction);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(131, 158, 158, 158),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Center(
                child: Text(widget.auction.created.toString()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Hero(
                tag: widget.auction.id,
                child: ClipRRect(
                  child: Image.network(
                      'http://localhost:8000/storage/${widget.auction.image}'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.auction.name),
                  Text(widget.auction.price.toString()), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


