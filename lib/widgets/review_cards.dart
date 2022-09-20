// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

class ReviewCards extends StatelessWidget {
  // RelatedEvent relatedEvent;
  // ReviewCards({required this.relatedEvent});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          // Positioned(
          //   right: 10,
          //   top: 20,
          //   child: CircleAvatar(
          //     radius: 28,
          //     backgroundColor: Colors.white,
          //     child: CircleAvatar(
          //       backgroundImage: NetworkImage('${relatedEvent.thumbnailEvent}'),
          //       radius: 25,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   right: 10,
          //   top: 80,
          //   child: Container(
          //     width: 150,
          //     child: Text(
          //       '${relatedEvent.title}',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //       maxLines: 3,
          //     ),
          //   ),
          //   // child: CircleAvatar(
          //   //   radius: 28,
          //   //   backgroundColor: Colors.white,
          //   //   child: CircleAvatar(
          //   //     backgroundImage: AssetImage('assets/top-image.jpg'),
          //   //     radius: 25,
          //   //   ),
          //   // ),
          // ),
          // Positioned(
          //   left: 10,
          //   top: 20,
          //   child: Row(
          //     // mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       // Text('(2) '),
          //       RatingBar.builder(
          //         initialRating: relatedEvent.averageRating!.toDouble(),
          //         minRating: 1,
          //         itemSize: 15,
          //         direction: Axis.horizontal,
          //         allowHalfRating: true,
          //         itemCount: 5,
          //         itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          //         itemBuilder: (context, _) => Icon(
          //           Icons.star,
          //           color: MyColors.topOrange,
          //         ),
          //         onRatingUpdate: (rating) {
          //           print(rating);
          //         },
          //       ),
          //       CircleAvatar(
          //         radius: 10,
          //         backgroundColor: Colors.white,
          //         child: Text(
          //           relatedEvent.numberComment.toString(),
          //           style: TextStyle(
          //             fontSize: 16,
          //             color: MyColors.topOrange,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //       // Text(
          //       //   ' 4',
          //       //   style: TextStyle(
          //       //     fontSize: 16,
          //       //     fontWeight: FontWeight.bold,
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          // Positioned(
          //   left: 10,
          //   top: 80,
          //   child: Row(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(8.0),
          //         decoration: BoxDecoration(
          //             color: Colors.black,
          //             borderRadius: BorderRadius.circular(8)),
          //         child: Text(
          //           'Purchased',
          //           style: TextStyle(
          //             fontSize: 13,
          //             color: Colors.white,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       Text(
          //         'ROTEM',
          //         style: TextStyle(
          //           fontSize: 20,
          //           color: Colors.black,
          //           fontWeight: FontWeight.w300,
          //         ),
          //       ),
          //     ],
          //   ),
          //   // child: CircleAvatar(
          //   //   radius: 28,
          //   //   backgroundColor: Colors.white,
          //   //   child: CircleAvatar(
          //   //     backgroundImage: AssetImage('assets/top-image.jpg'),
          //   //     radius: 25,
          //   //   ),
          //   // ),
          // ),
          // Positioned(
          //   right: 10,
          //   top: 120,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       // Text(
          //       //   '<"',
          //       //   textAlign: TextAlign.right,
          //       //   style: TextStyle(
          //       //     fontSize: 26,
          //       //     color: Colors.black,
          //       //     fontWeight: FontWeight.bold,
          //       //   ),
          //       // ),
          //       SizedBox(
          //         height: 40.0,
          //       ),
          //       // Text(
          //       //   '${relatedEvent.date}',
          //       //   style: TextStyle(
          //       //     fontSize: 16,
          //       //     color: Colors.black,
          //       //     fontWeight: FontWeight.w500,
          //       //   ),
          //       // ),
          //       SizedBox(
          //         height: 10.0,
          //       ),
          //       // Text(
          //       //   '${relatedEvent.title}',
          //       //   textAlign: TextAlign.right,
          //       //   style: TextStyle(
          //       //     fontSize: 16,
          //       //     color: Colors.black,
          //       //     fontWeight: FontWeight.w400,
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
