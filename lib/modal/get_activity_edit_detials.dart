//
//
// import 'dart:convert';
//
// GetUserActivityEditDetails getUserActivityEditDetailsFromJson(String str) => GetUserActivityEditDetails.fromJson(json.decode(str));
//
// String getUserActivityEditDetailsToJson(GetUserActivityEditDetails data) => json.encode(data.toJson());
//
// class GetUserActivityEditDetails {
//   GetUserActivityEditDetails({
//     this.success,
//     this.data,
//     this.error,
//   });
//
//   int? success;
//   Data? data;
//   dynamic error;
//
//   factory GetUserActivityEditDetails.fromJson(Map<String, dynamic> json) => GetUserActivityEditDetails(
//     success: json["success"],
//     data: Data.fromJson(json["data"]),
//     error: json["error"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data?.toJson(),
//     "error": error,
//   };
// }
//
// class Data {
//   Data({
//     this.id,
//     this.latEvent,
//     this.lngEvent,
//     this.title,
//     this.date,
//     this.thumbnailEvent,
//     this.markerPrice,
//     this.content,
//     this.mapAddress,
//     this.averageRating,
//     this.numberComment,
//     this.comments,
//     this.bookingDates,
//     this.gallery,
//     this.noOfTicket,
//     this.authorData,
//     this.shareLink,
//     this.linkVideo,
//     this.payment,
//     this.coupon,
//     this.activity,
//     this.eventCategory,
//     this.disableDate,
//   });
//
//   dynamic id;
//   dynamic latEvent;
//   dynamic lngEvent;
//   dynamic title;
//  dynamic date;
//   dynamic thumbnailEvent;
//   dynamic markerPrice;
//   dynamic content;
//   dynamic mapAddress;
//   dynamic averageRating;
//   dynamic numberComment;
//   List<dynamic>? comments;
//   List<dynamic>? bookingDates;
//   List<Gallery>? gallery;
//   List<NoOfTicket>? noOfTicket;
//   AuthorData? authorData;
//   dynamic shareLink;
//   dynamic linkVideo;
//   Payment? payment;
//   List<Coupon>? coupon;
//   Activity? activity;
//   List<EventCategory>? eventCategory;
//   List<DisableDate>? disableDate;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     latEvent: json["lat_event"],
//     lngEvent: json["lng_event"],
//     title: json["title"],
//     date: json["date"],
//     thumbnailEvent: json["thumbnail_event"],
//     markerPrice: json["marker_price"],
//     content: json["content"],
//     mapAddress: json["map_address"],
//     averageRating: json["average_rating"],
//     numberComment: json["number_comment"],
//     comments: List<dynamic>.from(json["comments"].map((x) => x)),
//     bookingDates: List<dynamic>.from(json["booking_dates"].map((x) => x)),
//     gallery: List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
//     noOfTicket: List<NoOfTicket>.from(json["no_of_ticket"].map((x) => NoOfTicket.fromJson(x))),
//     authorData: AuthorData.fromJson(json["author_data"]),
//     shareLink: json["share_link"],
//     linkVideo: json["link_video"],
//     payment: Payment.fromJson(json["payment"]),
//     coupon: List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))),
//     activity: Activity.fromJson(json["activity"]),
//     eventCategory: List<EventCategory>.from(json["event_category"].map((x) => EventCategory.fromJson(x))),
//     disableDate: List<DisableDate>.from(json["disable_date"].map((x) => DisableDate.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "lat_event": latEvent,
//     "lng_event": lngEvent,
//     "title": title,
//     "date": date,
//     "thumbnail_event": thumbnailEvent,
//     "marker_price": markerPrice,
//     "content": content,
//     "map_address": mapAddress,
//     "average_rating": averageRating,
//     "number_comment": numberComment,
//     "comments": List<dynamic>.from(comments!.map((x) => x)),
//     "booking_dates": List<dynamic>.from(bookingDates!.map((x) => x)),
//     "gallery": List<dynamic>.from(gallery!.map((x) => x.toJson())),
//     "no_of_ticket": List<dynamic>.from(noOfTicket!.map((x) => x.toJson())),
//     "author_data": authorData?.toJson(),
//     "share_link": shareLink,
//     "link_video": linkVideo,
//     "payment": payment?.toJson(),
//     "coupon": List<dynamic>.from(coupon!.map((x) => x.toJson())),
//     "activity": activity?.toJson(),
//     "event_category": List<dynamic>.from(eventCategory!.map((x) => x.toJson())),
//     "disable_date": List<dynamic>.from(disableDate!.map((x) => x.toJson())),
//   };
// }
//
// class Activity {
//   Activity({
//     this.timeOption,
//     this.calendarRecurrenceStartTime,
//     this.calendarRecurrenceEndTime,
//     this.activityRepeat,
//     this.recurrenceBydays,
//     this.calendarStartDate,
//     this.stopSell,
//   });
//
//   dynamic timeOption;
//   dynamic calendarRecurrenceStartTime;
//   dynamic calendarRecurrenceEndTime;
//   dynamic activityRepeat;
//   List<String>? recurrenceBydays;
//   dynamic calendarStartDate;
//   dynamic stopSell;
//
//   factory Activity.fromJson(Map<String, dynamic> json) => Activity(
//     timeOption: json["time_option"],
//     calendarRecurrenceStartTime: json["calendar_recurrence_start_time"],
//     calendarRecurrenceEndTime: json["calendar_recurrence_end_time"],
//     activityRepeat: json["activity_repeat"],
//     recurrenceBydays: List<String>.from(json["recurrence_bydays"].map((x) => x)),
//     calendarStartDate: json["calendar_start_date"],
//     stopSell: json["stop_sell"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "time_option": timeOption,
//     "calendar_recurrence_start_time": calendarRecurrenceStartTime,
//     "calendar_recurrence_end_time": calendarRecurrenceEndTime,
//     "activity_repeat": activityRepeat,
//     "recurrence_bydays": List<dynamic>.from(recurrenceBydays!.map((x) => x)),
//     "calendar_start_date": calendarStartDate,
//     "stop_sell": stopSell,
//   };
// }
//
// class AuthorData {
//   AuthorData({
//     this.firstName,
//     this.lastName,
//     this.description,
//     this.authorImg,
//     this.email,
//     this.phone,
//   });
//
//   dynamic firstName;
//   dynamic lastName;
//   dynamic description;
//   dynamic authorImg;
//   dynamic email;
//   dynamic phone;
//
//   factory AuthorData.fromJson(Map<String, dynamic> json) => AuthorData(
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     description: json["description"],
//     authorImg: json["author_img"],
//     email: json["email"],
//     phone: json["phone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "first_name": firstName,
//     "last_name": lastName,
//     "description": description,
//     "author_img": authorImg,
//     "email": email,
//     "phone": phone,
//   };
// }
//
// class Coupon {
//   Coupon({
//     this.couponId,
//     this.discountCode,
//     this.discountAmoutNumber,
//     this.discountAmountPercent,
//     this.startDate,
//     this.startTime,
//     this.endDate,
//     this.endTime,
//     this.quantity,
//   });
//
//   dynamic couponId;
//   dynamic discountCode;
//   dynamic discountAmoutNumber;
//   dynamic discountAmountPercent;
//   dynamic startDate;
//   dynamic startTime;
//   dynamic endDate;
//   dynamic endTime;
//   dynamic quantity;
//
//   factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
//     couponId: json["coupon_id"],
//     discountCode: json["discount_code"],
//     discountAmoutNumber: json["discount_amout_number"],
//     discountAmountPercent: json["discount_amount_percent"],
//     startDate: json["start_date"],
//     startTime: json["start_time"],
//     endDate: json["end_date"],
//     endTime: json["end_time"],
//     quantity: json["quantity"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "coupon_id": couponId,
//     "discount_code": discountCode,
//     "discount_amout_number": discountAmoutNumber,
//     "discount_amount_percent": discountAmountPercent,
//     "start_date": startDate,
//     "start_time": startTime,
//     "end_date": endDate,
//     "end_time": endTime,
//     "quantity": quantity,
//   };
// }
//
// class DisableDate {
//   DisableDate({
//     this.startDate,
//     this.endDate,
//   });
//
//   dynamic startDate;
//   dynamic endDate;
//
//   factory DisableDate.fromJson(Map<String, dynamic> json) => DisableDate(
//     startDate: json["start_date"],
//     endDate: json["end_date"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "start_date": startDate,
//     "end_date": endDate,
//   };
// }
//
// class EventCategory {
//   EventCategory({
//     this.termId,
//     this.name,
//     this.slug,
//     this.termGroup,
//     this.termTaxonomyId,
//     this.taxonomy,
//     this.description,
//     this.parent,
//     this.count,
//     this.filter,
//   });
//
//   dynamic termId;
//   dynamic name;
//   dynamic slug;
//   dynamic termGroup;
//   dynamic termTaxonomyId;
//   dynamic taxonomy;
//   dynamic description;
//   dynamic parent;
//   dynamic count;
//   dynamic filter;
//
//   factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
//     termId: json["term_id"],
//     name: json["name"],
//     slug: json["slug"],
//     termGroup: json["term_group"],
//     termTaxonomyId: json["term_taxonomy_id"],
//     taxonomy: json["taxonomy"],
//     description: json["description"],
//     parent: json["parent"],
//     count: json["count"],
//     filter: json["filter"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "term_id": termId,
//     "name": name,
//     "slug": slug,
//     "term_group": termGroup,
//     "term_taxonomy_id": termTaxonomyId,
//     "taxonomy": taxonomy,
//     "description": description,
//     "parent": parent,
//     "count": count,
//     "filter": filter,
//   };
// }
//
// class Gallery {
//   Gallery({
//     this.id,
//     this.url,
//   });
//
//   dynamic id;
//   dynamic url;
//
//   factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
//     id: json["id"],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "url": url,
//   };
// }
//
// class NoOfTicket {
//   NoOfTicket({
//     this.nameTicket,
//     this.ticketId,
//     this.typePrice,
//     this.priceTicket,
//     this.numberTotalTicket,
//     this.numberMinTicket,
//     this.numberMaxTicket,
//     this.startTicketDate,
//     this.startTicketTime,
//     this.closeTicketDate,
//     this.closeTicketTime,
//     this.colorTicket,
//     this.colorLabelTicket,
//     this.colorContentTicket,
//     this.descTicket,
//     this.imageTicket,
//     this.privateDescTicket,
//     this.onlineLink,
//     this.onlinePassword,
//     this.onlineOther,
//     this.seatList,
//     this.setupSeat,
//   });
//
//   dynamic nameTicket;
//   dynamic ticketId;
//   dynamic typePrice;
//   dynamic priceTicket;
//   dynamic numberTotalTicket;
//   dynamic numberMinTicket;
//   dynamic numberMaxTicket;
//   dynamic startTicketDate;
//   dynamic startTicketTime;
//   dynamic closeTicketDate;
//   dynamic closeTicketTime;
//   dynamic colorTicket;
//   dynamic colorLabelTicket;
//   dynamic colorContentTicket;
//   dynamic descTicket;
//   dynamic imageTicket;
//   dynamic privateDescTicket;
//   dynamic onlineLink;
//   dynamic onlinePassword;
//   dynamic onlineOther;
//   dynamic seatList;
//   dynamic setupSeat;
//
//   factory NoOfTicket.fromJson(Map<String, dynamic> json) => NoOfTicket(
//     nameTicket: json["name_ticket"],
//     ticketId: json["ticket_id"],
//     typePrice: json["type_price"],
//     priceTicket: json["price_ticket"],
//     numberTotalTicket: json["number_total_ticket"],
//     numberMinTicket: json["number_min_ticket"],
//     numberMaxTicket: json["number_max_ticket"],
//     startTicketDate: json["start_ticket_date"],
//     startTicketTime: json["start_ticket_time"],
//     closeTicketDate: json["close_ticket_date"],
//     closeTicketTime: json["close_ticket_time"],
//     colorTicket: json["color_ticket"],
//     colorLabelTicket: json["color_label_ticket"],
//     colorContentTicket: json["color_content_ticket"],
//     descTicket: json["desc_ticket"],
//     imageTicket: json["image_ticket"],
//     privateDescTicket: json["private_desc_ticket"],
//     onlineLink: json["online_link"],
//     onlinePassword: json["online_password"],
//     onlineOther: json["online_other"],
//     seatList: json["seat_list"],
//     setupSeat: json["setup_seat"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name_ticket": nameTicket,
//     "ticket_id": ticketId,
//     "type_price": typePrice,
//     "price_ticket": priceTicket,
//     "number_total_ticket": numberTotalTicket,
//     "number_min_ticket": numberMinTicket,
//     "number_max_ticket": numberMaxTicket,
//     "start_ticket_date": startTicketDate,
//     "start_ticket_time": startTicketTime,
//     "close_ticket_date": closeTicketDate,
//     "close_ticket_time": closeTicketTime,
//     "color_ticket": colorTicket,
//     "color_label_ticket": colorLabelTicket,
//     "color_content_ticket": colorContentTicket,
//     "desc_ticket": descTicket,
//     "image_ticket": imageTicket,
//     "private_desc_ticket": privateDescTicket,
//     "online_link": onlineLink,
//     "online_password": onlinePassword,
//     "online_other": onlineOther,
//     "seat_list": seatList,
//     "setup_seat": setupSeat,
//   };
// }
//
// class Payment {
//   Payment({
//     this.accountHolder,
//     this.accountNo,
//     this.bankName,
//     this.branch,
//   });
//
//   dynamic accountHolder;
//   dynamic accountNo;
//   dynamic bankName;
//   dynamic branch;
//
//   factory Payment.fromJson(Map<String, dynamic> json) => Payment(
//     accountHolder: json["account_holder"],
//     accountNo: json["account_no"],
//     bankName: json["bank_name"],
//     branch: json["branch"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "account_holder": accountHolder,
//     "account_no": accountNo,
//     "bank_name": bankName,
//     "branch": branch,
//   };
// }



class GetUserActivityEditDetails {
  int? success;
  Data? data;
  dynamic error;

  GetUserActivityEditDetails({this.success, this.data, this.error});

  GetUserActivityEditDetails.fromJson(Map<String, dynamic> json) {
   
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic latEvent;
  dynamic lngEvent;
  dynamic title;
  dynamic date;
  dynamic thumbnailEvent;
  dynamic markerPrice;
  dynamic content;
  dynamic mapAddress;
  dynamic averageRating;
  dynamic numberComment;
  List<Comments>? comments;
  List<BookingDates>? bookingDates;
  List<Gallery>? gallery;
  List<NoOfTicket>? noOfTicket;
  AuthorData? authorData;
  dynamic shareLink;
  dynamic linkVideo;
  Payment? payment;
  List<Coupon>? coupon;
  Activity? activity;
  List<EventCategory>? eventCategory;
  dynamic disableDate;

  Data(
      {this.id,
      this.latEvent,
      this.lngEvent,
      this.title,
      this.date,
      this.thumbnailEvent,
      this.markerPrice,
      this.content,
      this.mapAddress,
      this.averageRating,
      this.numberComment,
      this.comments,
      this.bookingDates,
      this.gallery,
      this.noOfTicket,
      this.authorData,
      this.shareLink,
      this.linkVideo,
      this.payment,
      this.coupon,
      this.activity,
      this.eventCategory,
      this.disableDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latEvent = json['lat_event'];
    lngEvent = json['lng_event'];
    title = json['title'];
    date = json['date'];
    thumbnailEvent = json['thumbnail_event'];
    markerPrice = json['marker_price'];
    content = json['content'];
    mapAddress = json['map_address'];
    averageRating = json['average_rating'];
    numberComment = json['number_comment'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['booking_dates'] != null) {
      bookingDates = <BookingDates>[];
      json['booking_dates'].forEach((v) {
        bookingDates!.add(new BookingDates.fromJson(v));
      });
    }
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    if (json['no_of_ticket'] != null) {
      noOfTicket = <NoOfTicket>[];
      json['no_of_ticket'].forEach((v) {
        noOfTicket!.add(new NoOfTicket.fromJson(v));
      });
    }
    authorData = json['author_data'] != null
        ? new AuthorData.fromJson(json['author_data'])
        : null;
    shareLink = json['share_link'];
    linkVideo = json['link_video'];
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    if (json['coupon'] != null) {
      coupon = <Coupon>[];
      json['coupon'].forEach((v) {
        coupon!.add(new Coupon.fromJson(v));
      });
    }
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    if (json['event_category'] != null) {
      eventCategory = <EventCategory>[];
      json['event_category'].forEach((v) {
        eventCategory!.add(new EventCategory.fromJson(v));
      });
    }
    disableDate = json['disable_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat_event'] = this.latEvent;
    data['lng_event'] = this.lngEvent;
    data['title'] = this.title;
    data['date'] = this.date;
    data['thumbnail_event'] = this.thumbnailEvent;
    data['marker_price'] = this.markerPrice;
    data['content'] = this.content;
    data['map_address'] = this.mapAddress;
    data['average_rating'] = this.averageRating;
    data['number_comment'] = this.numberComment;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.bookingDates != null) {
      data['booking_dates'] =
          this.bookingDates!.map((v) => v.toJson()).toList();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.noOfTicket != null) {
      data['no_of_ticket'] = this.noOfTicket!.map((v) => v.toJson()).toList();
    }
    if (this.authorData != null) {
      data['author_data'] = this.authorData!.toJson();
    }
    data['share_link'] = this.shareLink;
    data['link_video'] = this.linkVideo;
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.coupon != null) {
      data['coupon'] = this.coupon!.map((v) => v.toJson()).toList();
    }
    if (this.activity != null) {
      data['activity'] = this.activity!.toJson();
    }
    if (this.eventCategory != null) {
      data['event_category'] =
          this.eventCategory!.map((v) => v.toJson()).toList();
    }
    data['disable_date'] = this.disableDate;
    return data;
  }
}

class Comments {
  dynamic commentID;
  dynamic commentContent;
  dynamic commentDate;
  dynamic commentAuthorEmail;
  dynamic averageRating;
  bool? commentAuthor;
  dynamic commentImageAuthor;

  Comments(
      {this.commentID,
      this.commentContent,
      this.commentDate,
      this.commentAuthorEmail,
      this.averageRating,
      this.commentAuthor,
      this.commentImageAuthor});

  Comments.fromJson(Map<String, dynamic> json) {
    commentID = json['comment_ID'];
    commentContent = json['comment_content'];
    commentDate = json['comment_date'];
    commentAuthorEmail = json['comment_author_email'];
    averageRating = json['average_rating'];
    commentAuthor = json['comment_author'];
    commentImageAuthor = json['comment_image_author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_ID'] = this.commentID;
    data['comment_content'] = this.commentContent;
    data['comment_date'] = this.commentDate;
    data['comment_author_email'] = this.commentAuthorEmail;
    data['average_rating'] = this.averageRating;
    data['comment_author'] = this.commentAuthor;
    data['comment_image_author'] = this.commentImageAuthor;
    return data;
  }
}

class BookingDates {
  dynamic cartUrl;
  dynamic option;

  BookingDates({this.cartUrl, this.option});

  BookingDates.fromJson(Map<String, dynamic> json) {
    cartUrl = json['cart_url'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_url'] = this.cartUrl;
    data['option'] = this.option;
    return data;
  }
}

class Gallery {
  dynamic id;
  dynamic url;

  Gallery({this.id, this.url});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}

class NoOfTicket {
  dynamic ticketId;
  dynamic nameTicket;
  dynamic typePrice;
  dynamic priceTicket;
  dynamic numberTotalTicket;
  dynamic numberMinTicket;
  dynamic numberMaxTicket;
  dynamic startTicketDate;
  dynamic startTicketTime;
  dynamic closeTicketDate;
  dynamic closeTicketTime;
  dynamic colorTicket;
  dynamic colorLabelTicket;
  dynamic colorContentTicket;
  dynamic descTicket;
  dynamic privateDescTicket;
  dynamic imageTicket;
  dynamic setupSeat;

  NoOfTicket(
      {this.ticketId,
      this.nameTicket,
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
      this.privateDescTicket,
      this.imageTicket,
      this.setupSeat});

  NoOfTicket.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    nameTicket = json['name_ticket'];
    typePrice = json['type_price'];
    priceTicket = json['price_ticket'];
    numberTotalTicket = json['number_total_ticket'];
    numberMinTicket = json['number_min_ticket'];
    numberMaxTicket = json['number_max_ticket'];
    startTicketDate = json['start_ticket_date'];
    startTicketTime = json['start_ticket_time'];
    closeTicketDate = json['close_ticket_date'];
    closeTicketTime = json['close_ticket_time'];
    colorTicket = json['color_ticket'];
    colorLabelTicket = json['color_label_ticket'];
    colorContentTicket = json['color_content_ticket'];
    descTicket = json['desc_ticket'];
    privateDescTicket = json['private_desc_ticket'];
    imageTicket = json['image_ticket'];
    setupSeat = json['setup_seat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['name_ticket'] = this.nameTicket;
    data['type_price'] = this.typePrice;
    data['price_ticket'] = this.priceTicket;
    data['number_total_ticket'] = this.numberTotalTicket;
    data['number_min_ticket'] = this.numberMinTicket;
    data['number_max_ticket'] = this.numberMaxTicket;
    data['start_ticket_date'] = this.startTicketDate;
    data['start_ticket_time'] = this.startTicketTime;
    data['close_ticket_date'] = this.closeTicketDate;
    data['close_ticket_time'] = this.closeTicketTime;
    data['color_ticket'] = this.colorTicket;
    data['color_label_ticket'] = this.colorLabelTicket;
    data['color_content_ticket'] = this.colorContentTicket;
    data['desc_ticket'] = this.descTicket;
    data['private_desc_ticket'] = this.privateDescTicket;
    data['image_ticket'] = this.imageTicket;
    data['setup_seat'] = this.setupSeat;
    return data;
  }
}

class AuthorData {
  dynamic firstName;
  dynamic lastName;
  dynamic description;
  dynamic authorImg;
  dynamic email;
  dynamic phone;

  AuthorData(
      {this.firstName,
      this.lastName,
      this.description,
      this.authorImg,
      this.email,
      this.phone});

  AuthorData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    description = json['description'];
    authorImg = json['author_img'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['description'] = this.description;
    data['author_img'] = this.authorImg;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Payment {
  dynamic accountHolder;
  dynamic accountNo;
  dynamic bankName;
  dynamic branch;

  Payment({this.accountHolder, this.accountNo, this.bankName, this.branch});

  Payment.fromJson(Map<String, dynamic> json) {
    accountHolder = json['account_holder'];
    accountNo = json['account_no'];
    bankName = json['bank_name'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_holder'] = this.accountHolder;
    data['account_no'] = this.accountNo;
    data['bank_name'] = this.bankName;
    data['branch'] = this.branch;
    return data;
  }
}

class Coupon {
  dynamic couponId;
  dynamic discountCode;
  dynamic discountAmoutNumber;
  dynamic discountAmountPercent;
  dynamic startDate;
  dynamic startTime;
  dynamic endDate;
  dynamic endTime;
  dynamic allTicket;
  dynamic quantity;

  Coupon(
      {this.couponId,
      this.discountCode,
      this.discountAmoutNumber,
      this.discountAmountPercent,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.allTicket,
      this.quantity});

  Coupon.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    discountCode = json['discount_code'];
    discountAmoutNumber = json['discount_amout_number'];
    discountAmountPercent = json['discount_amount_percent'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    allTicket = json['all_ticket'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['discount_code'] = this.discountCode;
    data['discount_amout_number'] = this.discountAmoutNumber;
    data['discount_amount_percent'] = this.discountAmountPercent;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_date'] = this.endDate;
    data['end_time'] = this.endTime;
    data['all_ticket'] = this.allTicket;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Activity {
  dynamic timeOption;
  dynamic calendarRecurrenceStartTime;
  dynamic calendarRecurrenceEndTime;
  dynamic activityRepeat;
  List<String>? recurrenceBydays;
  dynamic calendarStartDate;
  dynamic stopSell;

  Activity(
      {this.timeOption,
      this.calendarRecurrenceStartTime,
      this.calendarRecurrenceEndTime,
      this.activityRepeat,
      this.recurrenceBydays,
      this.calendarStartDate,
      this.stopSell});

  Activity.fromJson(Map<String, dynamic> json) {
    timeOption = json['time_option'];
    calendarRecurrenceStartTime = json['calendar_recurrence_start_time'];
    calendarRecurrenceEndTime = json['calendar_recurrence_end_time'];
    activityRepeat = json['activity_repeat'];
    recurrenceBydays = json['recurrence_bydays'].cast<String>();
    calendarStartDate = json['calendar_start_date'];
    stopSell = json['stop_sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_option'] = this.timeOption;
    data['calendar_recurrence_start_time'] = this.calendarRecurrenceStartTime;
    data['calendar_recurrence_end_time'] = this.calendarRecurrenceEndTime;
    data['activity_repeat'] = this.activityRepeat;
    data['recurrence_bydays'] = this.recurrenceBydays;
    data['calendar_start_date'] = this.calendarStartDate;
    data['stop_sell'] = this.stopSell;
    return data;
  }
}

class EventCategory {
  dynamic termId;
  dynamic name;
  dynamic slug;
  dynamic termGroup;
  dynamic termTaxonomyId;
  dynamic taxonomy;
  dynamic description;
  dynamic parent;
  dynamic count;
  dynamic filter;

  EventCategory(
      {this.termId,
      this.name,
      this.slug,
      this.termGroup,
      this.termTaxonomyId,
      this.taxonomy,
      this.description,
      this.parent,
      this.count,
      this.filter});

  EventCategory.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    data['term_taxonomy_id'] = this.termTaxonomyId;
    data['taxonomy'] = this.taxonomy;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['count'] = this.count;
    data['filter'] = this.filter;
    return data;
  }
}
