// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:basalon/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../services/my_color.dart';

class CommentCard extends StatefulWidget {
  CommentCard(
      {required this.commentContent,
      required this.commentDate,
      required this.commentRating,
      this.image,
      this.userEmail,
      this.desc});

  String commentDate;
  String commentContent;
  dynamic commentRating;
  dynamic userEmail;
  dynamic image;

  dynamic desc;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final now = new DateTime.now();

  TextEditingController contentController = TextEditingController();

  dynamic rateEvent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: widget.commentRating + .0,
                            minRating: 1,
                            itemSize: 20,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rounded,
                              color: Colors.amber.shade700,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                            tapOnlyMode: true,
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: MyColors.topOrange)),
                            child: Center(
                              child: Text(
                                '${widget.commentRating}',
                                style: TextStyle(color: MyColors.topOrange),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          widget.image == null
                              ? CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/dummy_user.png'),
                                  backgroundColor: Colors.transparent,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    widget.image,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  // Text(
                  //   '.Your comment is awaiting moderation',
                  // ),

                  Text(
                    widget.userEmail,
                    style: ktextStyleBold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.commentDate,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.commentContent}',
                    textAlign: TextAlign.right,
                    style: ktextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(3)),
      ),
    );
  }
}
