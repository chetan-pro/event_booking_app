// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:basalon/network/get_events_network.dart';
import 'package:basalon/screens/activity/receiving_activity_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';
import '../constant/login_user.dart';
import '../services/my_color.dart';
import 'custom_buttons.dart';

class FeedbackCard extends StatefulWidget {
  FeedbackCard({required this.eventId, this.function});

  dynamic eventId;
  dynamic function;

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  TextEditingController contentController = TextEditingController();
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  dynamic rateEvent;

  late FetchEventData _fetchEventData = FetchEventData(
    commentContent: contentController.text,
    rating: rateEvent,
    eventId: widget.eventId,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'ספרו איך היה לכם',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  'דירוג',
                  style: ktextStyle,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: RatingBar.builder(
                    initialRating: 0,
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
                      setState(() {
                        rateEvent = rating;
                      });
                      print(rating);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ReceivingPaymentFields(
              controller: contentController,
              obscureText: false,
              maxLine: 6,
              label: '',
              // hintText: 'Your comment',
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomButton(
                  isOutlinedButton: true,
                  outlineColor: MyColors.topOrange,
                  width: 100,
                  text: 'שליחה',
                  textStyle: TextStyle(
                    color: MyColors.topOrange,
                  ),
                  onPressed: () {
                    _fetchEventData.postFeedbackEventDetails(
                      context,
                      LoginUser.shared?.userId! ??
                          application.idFromLocalProvider,
                      content: contentController.text,
                      rating: rateEvent,
                      eventId: widget.eventId,
                    );
                    print('+++++++++++++++++++++++++++++++++++++++++');
                    print(widget.eventId);
                    print(rateEvent);
                    print(contentController.text);

                    setState(() {});
                    widget.function;
                  }),
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
