import 'dart:async';

import 'package:basalon/network/favorite_network.dart';
import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/services/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../blocs/application_bloc.dart';
import '../../../constant/login_user.dart';
import '../../event_detail_screen.dart';

class MyFavorites extends StatefulWidget {
  MyFavorites({
    Key? key,
    this.id,
  }) : super(key: key);

  dynamic id;

  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  final FetchFavoriteEvents _fetchFavoriteEvents = FetchFavoriteEvents();

  @override
  void initState() {
    super.initState();
    _fetchFavoriteEvents.getFavorite(application.idFromLocalProvider != null
        ? application.idFromLocalProvider
        : LoginUser.shared?.userId);
    stream = getFavorites();
  }

  late final application = Provider.of<ApplicationBloc>(context, listen: false);

  Stream getFavorites() async* {
    await Future.delayed(Duration(milliseconds: 100), () {
      return _fetchFavoriteEvents.getFavorite(
          application.idFromLocalProvider != null
              ? application.idFromLocalProvider
              : LoginUser.shared?.userId);
    });
    setState(() {});
  }

  late Stream stream;
  late double width = MediaQuery.of(context).size.width;
  StreamController streamController = StreamController();

  Future<bool> willPop() async {
    final shouldpop = await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    return shouldpop;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                      )),
                  Text(
                    'המועדפים שלי',
                    style: ktextStyleLarge,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
                    var x = _fetchFavoriteEvents.favoriteEvents?.data;
                    print(x?.length);

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CupertinoActivityIndicator(
                        radius: 20,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {}

                    return (x != null)
                        ? ListView.builder(
                            itemCount: x.length,
                            padding: const EdgeInsets.only(
                              left: 5,
                            ),
                            itemBuilder: (context, index) {
                              print('yyyyyyyyyyyyyyyyyyy');
                              print(x.length);
                              return Card(
                                margin: EdgeInsets.zero,
                                color: index % 2 == 0
                                    ? const Color.fromRGBO(247, 247, 247, 1)
                                    : const Color.fromRGBO(237, 237, 237, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        FavoriteColumn(
                                          content: '${x[index].address}',
                                          title: 'כתובת',
                                          titleContent: '',
                                        ),
                                        // FavoriteColumn(
                                        //   content: '${x[index].startDate}',
                                        //   title: 'מועד הפעילות',
                                        //   titleContent: '',
                                        // ),
                                        FavoriteColumn(
                                          titleContent: '${x[index].title}',
                                          title: 'שם הפעילות',
                                          content: '',
                                          shareLink: x[index].getPermlink,
                                          id: x[index].eventId,
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          _fetchFavoriteEvents.removeFavorite(
                                              application.idFromLocalProvider !=
                                                      null
                                                  ? application
                                                      .idFromLocalProvider
                                                  : LoginUser.shared?.userId,
                                              _fetchFavoriteEvents
                                                  .favoriteEvents
                                                  ?.data?[index]
                                                  .eventId);
                                          print('deleted');

                                          setState(() {
                                            stream = getFavorites();
                                            x.length--;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 10, right: 10),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Colors.red,
                                            size: 15,
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child:
                                Text("You don't have any event in wishlist."),
                          );
                    // Center(child: Text('You dont have any event in wishlist.'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteColumn extends StatelessWidget {
  FavoriteColumn(
      {required this.title,
      required this.content,
      required this.titleContent,
      this.shareLink,
      this.id});

  String title;
  String content;
  String titleContent;
  String? shareLink;
  dynamic id;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: ktextStyleBold,
              ),
              if (content.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(content),
                ),

              // Link(
              //   uri: Uri.parse(shareLink ?? ''),
              //   target: LinkTarget.defaultTarget,
              //   builder:
              //       (BuildContext context, Future<void> Function()? followLink) =>
              //           TextButton(
              //     onPressed: followLink,
              //     child: Text(titleContent),
              //   ),
              // ),
              if (titleContent.isNotEmpty)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetailScreen(
                                  id: id,
                                )));
                  },
                  child: Text(
                    titleContent,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
