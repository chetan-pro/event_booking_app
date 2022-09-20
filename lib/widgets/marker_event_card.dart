import 'package:basalon/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
// import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

import '../blocs/application_bloc.dart';
import '../constant/login_user.dart';
import '../network/favorite_network.dart';
import '../screens/event_detail_screen.dart';
import '../services/my_color.dart';

class MarkerEventCard extends StatefulWidget {
  dynamic datum;
  String? email;

  MarkerEventCard({this.datum, this.email});

  @override
  State<MarkerEventCard> createState() => _MarkerEventCardState();
}

class _MarkerEventCardState extends State<MarkerEventCard> {
  bool isLiked = false;
  final FetchFavoriteEvents _fetchFavoriteEvents = FetchFavoriteEvents();
  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        // linkUrl: 'https://basalon.co.il/event/סדנת-חקלאות-בסביבה-הביתית/',
        linkUrl: '${widget.datum.shareLink}',
        chooserTitle: 'Example Chooser Title');
  }

  bool isShare = false;
  late var dateSplit = widget.datum.date;

  @override
  Widget build(BuildContext context) {
    // print(widget.datum['mapAddress']);
    print("mapDatahere");
    // print(widget.datum.mapAddress);
    print("sakjdhjkas");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    print(
        'marker marker marker marker marker marker marker marker marker marker marker marker marker marker marker marker marker marker ');
    // print(datum);
    return Container(
      // height: 300,
      constraints: BoxConstraints.tightFor(height: 180),
      // margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print('Navigation to event detail page.');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetailScreen(
                                  id: widget.datum.id!.toInt(),
                                )));
                  },
                  child: Container(
                    // height: 120,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 5,
                      bottom: 10,
                    ),
                    // color: Colors.red,
                    decoration: const BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.network('${widget.datum.thumbnailEvent}',
                        height: 150, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  left: 10,
                  // bottom: 20,
                  top: 10,
                  child: InkWell(
                    onTap: () {
                      if (!isLiked) {
                        _fetchFavoriteEvents.addToFavorite(
                            application.idFromLocalProvider != null
                                ? application.idFromLocalProvider
                                : LoginUser.shared?.userId,
                            widget.datum.id);
                      }

                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          // backgroundImage: AssetImage('assets/icons/fav card.png'),
                          child: isLiked
                              ? Icon(
                                  Icons.favorite_sharp,
                                  color: Colors.pink,
                                  size: 18,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                  size: 18,
                                )
                          // Icon(
                          //   isLiked
                          //       ? Icons.favorite_sharp
                          //       : Icons.favorite_border,
                          //   color: Color(0XFFe86c60),
                          // ),
                          ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Row(
                    children: [
                      for (var item in widget.datum.categoryData)
                        //   for (int i = 0;
                        //       i < widget.datum.categoryData.length;
                        //       i++)
                        Container(
                          decoration: BoxDecoration(
                              color: Color(int.parse('0xff${item.color}'))
                                  .withOpacity(1),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(left: 5),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text('${item.name}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                    ],
                  ),
                ),
                if (isShare)
                  Positioned(
                    // bottom: 50,
                    left: 10,
                    top: 40,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: share,
                            child: Image.asset(
                              'assets/icons/messenger-icon.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Link(
                            uri: Uri.parse(
                                'mailto:${widget.email}?body=${widget.datum.shareLink}'),
                            target: LinkTarget.defaultTarget,
                            builder: (BuildContext context,
                                    Future<void> Function()? followLink) =>
                                GestureDetector(
                              onTap: followLink,
                              child: Image.asset(
                                'assets/icons/email-icon.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Link(
                            uri: Uri.parse(
                                'https://api.whatsapp.com/send/?text=${widget.datum.shareLink}&app_absent=0'),
                            target: LinkTarget.defaultTarget,
                            builder: (BuildContext context,
                                    Future<void> Function()? followLink) =>
                                GestureDetector(
                                    onTap: followLink,
                                    child: Image.asset(
                                      'assets/icons/whatsapp-icon.png',
                                      width: 25,
                                      height: 25,
                                    )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Link(
                            uri: Uri.parse(
                                'https://www.facebook.com/sharer.php?u=${widget.datum.shareLink}'),
                            target: LinkTarget.defaultTarget,
                            builder: (BuildContext context,
                                    Future<void> Function()? followLink) =>
                                GestureDetector(
                                    onTap: () async {
                                      // await FlutterSocialContentShare.share(
                                      //     type: ShareType.facebookWithoutImage,
                                      //     url: "${widget.datum.shareLink}",
                                      //     quote: "Basalon");
                                    },
                                    child: Image.asset(
                                      'assets/icons/fb-icon.png',
                                      width: 25,
                                      height: 25,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  left: 45,
                  // bottom: 20,
                  top: 10,
                  child: InkWell(
                    // onTap: share,
                    onTap: () {
                      setState(() {
                        isShare = !isShare;
                      });
                    },
                    //last
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        // backgroundImage: AssetImage('assets/icons/Share.png'),
                        child: Icon(
                          Icons.share,
                          size: 18,
                          color: Colors.black,
                        ),
                        radius: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventDetailScreen(
                                          id: widget.datum.id!.toInt(),
                                        )));
                          },
                          child: Text('${widget.datum.title}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              // 'name',

                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (widget.datum.numberComment != 0 &&
                          widget.datum.averageRating != 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '(${widget.datum.numberComment})',
                              style: TextStyle(
                                color: Colors.grey,
                                // fontFamily: 'Alef',
                                fontSize: 12,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating:
                                  widget.datum.averageRating!.toDouble(),
                              minRating: 1,
                              itemSize: 15,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                // color: MyColors.topOrange,
                                color: Colors.amber.shade700,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                      // SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                  text: dateSplit.day,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " | ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: dateSplit.startTime,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " | ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${dateSplit.dayNo} ב${dateSplit.month}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ]),
                            ),

                            // Text(
                            //   '${widget.datum.date}',
                            //   textDirection: TextDirection.rtl,
                            //   style: ktextStyleSmall,
                            // ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/icons/calendar.jpeg',
                                height: 20,
                                width: 20,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // if(widget.datum.mapAddress != "")
                                Expanded(
                                  child: Text(
                                    '${widget.datum.address.toString()}',
                                    // 'שיינקין , גבעתיים',
                                    style: ktextStyleSmall,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: MyColors.topOrange,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (widget.datum.ticketRest.isNotEmpty &&
                                  int.parse(widget.datum.ticketRest.replaceAll(
                                          new RegExp(r'[^0-9]'), '')) <
                                      10)
                              ? Container(
                                  margin: EdgeInsets.only(left: 5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColors.topOrange, width: 2)),
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(
                                            style: ktextStyleBoldSmall,
                                            text: '  נותרו ',
                                            children: [
                                          // TextSpan(text: widget.datum.ticketRest),
                                          // if( widget.datum.ticketRest != '' && int.parse(widget.datum.ticketRest.replaceAll(new RegExp(r'[^0-9]'), '')) < 10)
                                          TextSpan(
                                              text:
                                                  '${widget.datum.ticketRest.replaceAll(new RegExp(r'[^0-9]'), '')}'),
                                          TextSpan(text: ' מקומות  '),
                                        ])),
                                  ),
                                )
                              : SizedBox(),
                          // SizedBox(
                          //   width: 14.0,
                          // ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: MyColors.topOrange),
                            padding: EdgeInsets.only(
                                left: 10, right: 6, top: 5, bottom: 5),
                            child: Text(
                              // (widget.datum.ticketRest.isNotEmpty)
                              '${widget.datum.priceJk}',
                              //  '₪34',
                              // '₪${ datum.noOfTicket[0].priceTicket}',
                              style: ktextStyleWhite,
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   'נשארו רק עוד  8  כרטיסים',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     // fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 10.0,
          )
        ],
      ),
    );
  }
}
