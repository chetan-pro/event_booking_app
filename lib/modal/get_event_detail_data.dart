// import 'dart:convert';
//
// EventData getEventDetailfromJson(String string) =>
//     EventData.fromJson(json.decode(string));
// String getEventDataToJson(EventData getEventDetail) =>
//     json.encode(getEventDetail.toJson());
//
// class EventData {
//   EventData(
//     this.thumbnailEvent,
//     this.date,
//     this.averageRating,
//     this.numberComment,
//     this.title,
//     this.markerPrice,
//     this.lngEvent,
//     this.latEvent,
//     this.id,
//     this.comments,
//     this.content,
//     this.gallery,
//     this.mapAddress,
//   );
//
//   final String id;
//   final String latEvent;
//   final String lngEvent;
//   final String title;
//   final String date;
//   final String thumbnailEvent;
//   final String markerPrice;
//   final String content;
//   final String mapAddress;
//   final int averageRating;
//   final int numberComment;
//   final List<Null> comments;
//
//   // List<RelatedEvent> relatedEvent;
//   // List<BookingDates>? bookingDates;
//   final List<String> gallery;
//
//   factory EventData.fromMap(Map<String, dynamic> json) {
//     return EventData(
//       json['thumbnail_event'],
//       json['date'],
//       json['average_rating'],
//       json['number_comment'],
//       json['title'],
//       json['marker_price'],
//       json['lng_event'],
//       json['lat_event'],
//       json['id'],
//       json['comments'],
//       json['content'],
//       json['gallery'],
//       json['mapAddress'],
//     );
//   }
//   factory EventData.fromJson(Map<String, dynamic> json) {
//     return EventData(
//       json['thumbnail_event'],
//       json['date'],
//       json['average_rating'],
//       json['number_comment'],
//       json['title'],
//       json['marker_price'],
//       json['lng_event'],
//       json['lat_event'],
//       json['id'],
//       json['comments'],
//       json['content'],
//       json['gallery'],
//       json['mapAddress'],
//     );
//   }
// }
//
// // import 'dart:convert';
// //
// // GetEventDetail getEventDetailfromJson(String string) =>
// //     GetEventDetail.fromJson(json.decode(string));
// // String getEventDataToJson(GetEventDetail getEventDetail) =>
// //     json.encode(getEventDetail.toJson());
// //
// // class GetEventDetail {
// //   GetEventDetail(
// //       {required this.success, required this.error, required this.data});
// //
// //   int success;
// //   dynamic error;
// //   EventData data;
// //
// //   factory GetEventDetail.fromJson(Map<String, dynamic> json) => GetEventDetail(
// //         success: json['success'],
// //         data: EventData.fromJson(json['data']),
// //         error: json['error'],
// //       );
// //   Map<String, dynamic> toJson() => {
// //         "success": success,
// //         "data": data.toJson(),
// //         "error": error,
// //       };
// // }
// //
// // class EventData {
// //   EventData({
// //     thumbnailEvent,
// //     date,
// //     averageRating,
// //     numberComment,
// //     title,
// //     markerPrice,
// //     lngEvent,
// //     latEvent,
// //     id,
// //     comments,
// //     content,
// //     gallery,
// //     mapAddress,
// //   })  : thumbnailEvent = '',
// //         date = '',
// //         averageRating = 0,
// //         numberComment = 0,
// //         title = '',
// //         markerPrice = '',
// //         lngEvent = '',
// //         latEvent = '',
// //         id = '',
// //         comments = [],
// //         content = '',
// //         gallery = [],
// //         mapAddress = '';
// //
// //   String id;
// //   String latEvent;
// //   String lngEvent;
// //   String title;
// //   String date;
// //   String thumbnailEvent;
// //   String markerPrice;
// //   String content;
// //   String mapAddress;
// //   int averageRating;
// //   int numberComment;
// //   List<Null> comments;
// //
// //   // List<RelatedEvent> relatedEvent;
// //   // List<BookingDates>? bookingDates;
// //   List<String> gallery;
// //
// // // List<NoOfTicket>? noOfTicket;
// //   factory EventData.fromJson(Map<String, dynamic> json) => EventData(
// //         thumbnailEvent: json['thumbnail_event'],
// //         date: json['date'],
// //         averageRating: json['average_rating'],
// //         numberComment: json['number_comment'],
// //         title: json['title'],
// //         markerPrice: json['marker_price'],
// //         lngEvent: json['lng_event'],
// //         latEvent: json['lat_event'],
// //         id: json['id'],
// //         comments: json['comments'],
// //         content: json['content'],
// //         gallery: json['gallery'],
// //         mapAddress: json['mapAddress'],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "thumbnail_event": thumbnailEvent,
// //         "date": date,
// //         "average_rating": averageRating,
// //         "number_comment": numberComment,
// //         "title": title,
// //         "marker_price": markerPrice,
// //         "lng_event": lngEvent,
// //         "lat_event": latEvent,
// //         // "comments": comments,
// //         "content": content,
// //         "gallery": gallery,
// //         "mapAddress": mapAddress,
// //       };
// // }
// //
// // class RelatedEvent {
// //   dynamic id;
// //   String? title;
// //   String? date;
// //   dynamic averageRating;
// //   dynamic numberComment;
// //   String? thumbnailEvent;
// //   String? markerPrice;
// //
// //   RelatedEvent(
// //       {this.id,
// //       this.title,
// //       this.date,
// //       this.averageRating,
// //       this.numberComment,
// //       this.thumbnailEvent,
// //       this.markerPrice});
// //
// //   RelatedEvent.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     title = json['title'];
// //     date = json['date'];
// //     averageRating = json['average_rating'];
// //     numberComment = json['number_comment'];
// //     thumbnailEvent = json['thumbnail_event'];
// //     markerPrice = json['marker_price'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['title'] = this.title;
// //     data['date'] = this.date;
// //     data['average_rating'] = this.averageRating;
// //     data['number_comment'] = this.numberComment;
// //     data['thumbnail_event'] = this.thumbnailEvent;
// //     data['marker_price'] = this.markerPrice;
// //     return data;
// //   }
// // }

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.success,
    this.data,
    this.error,
  });

  dynamic success;
  Data? data;
  dynamic error;

  factory Welcome.fromJson(Map<String, dynamic> json) {
    print("json data checking 0");
    print(json);
    print("json data checking 1");
    return Welcome(
      success: json["success"],
      data: Data.fromJson(json["data"]),
      error: json["error"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  Data(
      {this.id,
      this.latEvent,
      this.lngEvent,
      this.title = '',
      this.date,
      this.thumbnailEvent,
      this.markerPrice,
      this.content,
      this.mapAddress,
      this.averageRating,
      this.numberComment,
      this.comments,
      // this.relatedEvent,
      this.bookingDates,
      this.gallery,
      this.noOfTicket,
      this.shareLink,
      this.authorData,
      this.linkVideo,
      this.ticketRest,
      this.customView});

  String? id;
  String? latEvent;
  String? lngEvent;
  String title;
  String? date;
  String? thumbnailEvent;
  String? markerPrice;
  String? content;
  String? mapAddress;
  dynamic averageRating;
  dynamic numberComment;
  List<Comment>? comments;
  int? customView;
  List<BookingDate>? bookingDates;
  List<Gallery>? gallery;
  List<NoOfTicket>? noOfTicket;
  String? shareLink;
  String? linkVideo;
  String? ticketRest;

  AuthorData? authorData;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json["id"],
        latEvent: json["lat_event"],
        lngEvent: json["lng_event"],
        title: json["title"],
        date: json["date"],
        thumbnailEvent: json["thumbnail_event"],
        markerPrice: json["marker_price"],
        content: json["content"],
        ticketRest: json["ticket_rest"],
        mapAddress: json["map_address"],
        averageRating: json["average_rating"],
        numberComment: json["number_comment"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        // relatedEvent: List<RelatedEvent>.from(
        //     json["related_event"].map((x) => RelatedEvent.fromJson(x))),
        bookingDates: List<BookingDate>.from(
            json["booking_dates"].map((x) => BookingDate.fromJson(x))),
        gallery:
            List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        noOfTicket: List<NoOfTicket>.from(
            json["no_of_ticket"].map((x) => NoOfTicket.fromJson(x))),
        shareLink: json["share_link"],
        authorData: AuthorData.fromJson(json["author_data"]),
        linkVideo: json["link_video"],
        customView: json['custum_view']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat_event": latEvent,
        "lng_event": lngEvent,
        "title": title,
        "date": date,
        "thumbnail_event": thumbnailEvent,
        "marker_price": markerPrice,
        "content": content,
        "map_address": mapAddress,
        "average_rating": averageRating,
        "number_comment": numberComment,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        // "related_event":
        //     List<dynamic>.from(relatedEvent!.map((x) => x.toJson())),
        "booking_dates":
            List<dynamic>.from(bookingDates!.map((x) => x.toJson())),
        "gallery": List<dynamic>.from(gallery!.map((x) => x.toJson())),
        "no_of_ticket": List<dynamic>.from(noOfTicket!.map((x) => x.toJson())),
        "share_link": shareLink,
        "ticket_rest": ticketRest,
        "author_data": authorData?.toJson(),
        "link_video": linkVideo,
        'custum_view': customView
      };
}

class BookingDate {
  BookingDate({
    this.cartUrl,
    this.eventDate,
    this.date1,
    this.date2,
    this.startTime,
    this.endTime,
    this.option,
  });

  String? cartUrl;
  String? eventDate;
  String? date1;
  String? date2;
  String? startTime;
  String? endTime;
  String? option;

  factory BookingDate.fromJson(Map<String, dynamic> json) => BookingDate(
        cartUrl: json["cart_url"],
        eventDate: json["event_date"],
        date1: json["date1"],
        date2: json["date2"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "cart_url": cartUrl,
        "eventDate": eventDate,
        "date1": date1,
        "date2": date2,
        "start_time": startTime,
        "end_time": endTime,
        "option": option,
      };
}

class Gallery {
  Gallery({
    this.id,
    this.url,
  });

  String? id;
  String? url;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class Comment {
  Comment({
    this.commentId,
    this.commentContent,
    this.commentDate,
    this.commentAuthorEmail,
    this.averageRating,
    // this.commentAuthor,
    this.commentImageAuthor,
  });

  String? commentId;
  String? commentContent;
  dynamic commentDate;
  String? commentAuthorEmail;
  dynamic averageRating;

  // bool? commentAuthor;
  String? commentImageAuthor;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["comment_ID"],
        commentContent: json["comment_content"],
        commentDate: json["comment_date"],
        commentAuthorEmail: json["comment_author_email"],
        averageRating: json["average_rating"],
        // commentAuthor: json["comment_author"],
        commentImageAuthor: json["comment_image_author"],
      );

  Map<String, dynamic> toJson() => {
        "comment_ID": commentId,
        "comment_content": commentContent,
        "comment_date": commentDate,
        "comment_author_email": commentAuthorEmail,
        "average_rating": averageRating,
        // "comment_author": commentAuthor,
        "comment_image_author": commentImageAuthor,
      };
}

class NoOfTicket {
  NoOfTicket({
    this.nameTicket,
    this.ticketId,
    this.typePrice,
    this.priceTicket,
    this.numberTotalTicket,
    this.numberMinTicket,
    this.numberMaxTicket,
    this.startTicketDate,
    this.startTicketTime,
    this.closeTicketDate,
    this.closeTicketTime,
    this.colorTicket,
    this.colorLabelTicket,
    this.colorContentTicket,
    this.descTicket,
    this.imageTicket,
    this.privateDescTicket,
    this.onlineLink,
    this.onlinePassword,
    this.onlineOther,
    this.seatList,
    this.setupSeat,
  });

  String? nameTicket;
  String? ticketId;
  String? typePrice;
  String? priceTicket;
  String? numberTotalTicket;
  String? numberMinTicket;
  String? numberMaxTicket;
  String? startTicketDate;
  String? startTicketTime;
  String? closeTicketDate;
  String? closeTicketTime;
  String? colorTicket;
  String? colorLabelTicket;
  String? colorContentTicket;
  String? descTicket;
  String? imageTicket;
  String? privateDescTicket;
  String? onlineLink;
  String? onlinePassword;
  String? onlineOther;
  String? seatList;
  String? setupSeat;

  factory NoOfTicket.fromJson(Map<String, dynamic> json) => NoOfTicket(
        nameTicket: json["name_ticket"],
        ticketId: json["ticket_id"],
        typePrice: json["type_price"],
        priceTicket: json["price_ticket"],
        numberTotalTicket: json["number_total_ticket"],
        numberMinTicket: json["number_min_ticket"],
        numberMaxTicket: json["number_max_ticket"],
        startTicketDate: json["start_ticket_date"],
        startTicketTime: json["start_ticket_time"],
        closeTicketDate: json["close_ticket_date"],
        closeTicketTime: json["close_ticket_time"],
        colorTicket: json["color_ticket"],
        colorLabelTicket: json["color_label_ticket"],
        colorContentTicket: json["color_content_ticket"],
        descTicket: json["desc_ticket"],
        imageTicket: json["image_ticket"],
        privateDescTicket: json["private_desc_ticket"],
        onlineLink: json["online_link"],
        onlinePassword: json["online_password"],
        onlineOther: json["online_other"],
        seatList: json["seat_list"],
        setupSeat: json["setup_seat"],
      );

  Map<String, dynamic> toJson() => {
        "name_ticket": nameTicket,
        "ticket_id": ticketId,
        "type_price": typePrice,
        "price_ticket": priceTicket,
        "number_total_ticket": numberTotalTicket,
        "number_min_ticket": numberMinTicket,
        "number_max_ticket": numberMaxTicket,
        "start_ticket_date": startTicketDate,
        "start_ticket_time": startTicketTime,
        "close_ticket_date": closeTicketDate,
        "close_ticket_time": closeTicketTime,
        "color_ticket": colorTicket,
        "color_label_ticket": colorLabelTicket,
        "color_content_ticket": colorContentTicket,
        "desc_ticket": descTicket,
        "image_ticket": imageTicket,
        "private_desc_ticket": privateDescTicket,
        "online_link": onlineLink,
        "online_password": onlinePassword,
        "online_other": onlineOther,
        "seat_list": seatList,
        "setup_seat": setupSeat,
      };
}

class SharingLink {
  SharingLink({
    this.whatsapp,
    this.facebook,
    this.twitter,
    this.pinterest,
    this.mail,
  });

  String? whatsapp;
  String? facebook;
  String? twitter;
  String? pinterest;
  String? mail;

  factory SharingLink.fromJson(Map<String, dynamic> json) => SharingLink(
        whatsapp: json["whatsapp"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        pinterest: json["pinterest"],
        mail: json["mail"],
      );

  Map<String, dynamic> toJson() => {
        "whatsapp": whatsapp,
        "facebook": facebook,
        "twitter": twitter,
        "pinterest": pinterest,
        "mail": mail,
      };
}

class AuthorData {
  AuthorData({
    this.firstName,
    this.lastName,
    this.description,
    this.authorImg,
  });

  String? firstName;
  String? lastName;
  String? description;
  String? authorImg;

  factory AuthorData.fromJson(Map<String, dynamic> json) => AuthorData(
        firstName: json["first_name"],
        lastName: json["last_name"],
        description: json["description"],
        authorImg: json["author_img"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "description": description,
        "author_img": authorImg,
      };
}
