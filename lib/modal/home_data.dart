// class HomeData {
//   int? success;
//   List<Data>? data;
//   int? countEvent;
//   Null? error;
//   HomeData({this.success, this.data, this.countEvent, this.error});
//   HomeData.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     countEvent = json['count_event'];
//     error = json['error'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['count_event'] = this.countEvent;
//     data['error'] = this.error;
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? latEvent;
//   String? lngEvent;
//   String? title;
//   Date? date;
//   int? averageRating;
//   int? numberComment;
//   String? thumbnailEvent;
//   String? address;
//   double? distance;
//   String? date1;
//   String? priceJk;
//   String? ticketRest;
//   List<CategoryData>? categoryData;
//   String? markerPrice;
//   String? markerDate;
//   String? showFeatured;
//   String? shareLink;

//   Data(
//       {this.id,
//       this.latEvent,
//       this.lngEvent,
//       this.title,
//       this.date,
//       this.averageRating,
//       this.numberComment,
//       this.thumbnailEvent,
//       this.address,
//       this.distance,
//       this.date1,
//       this.priceJk,
//       this.ticketRest,
//       this.categoryData,
//       this.markerPrice,
//       this.markerDate,
//       this.showFeatured,
//       this.shareLink});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     latEvent = json['lat_event'];
//     lngEvent = json['lng_event'];
//     title = json['title'];
//     date = json['date'] != null ? new Date.fromJson(json['date']) : null;
//     averageRating = json['average_rating'];
//     numberComment = json['number_comment'];
//     thumbnailEvent = json['thumbnail_event'];
//     address = json['address'];
//     distance = json['distance'];
//     date1 = json['date1'];
//     priceJk = json['price_jk'];
//     ticketRest = json['ticket_rest'];
//     if (json['category_data'] != null) {
//       categoryData = <CategoryData>[];
//       json['category_data'].forEach((v) {
//         categoryData!.add(new CategoryData.fromJson(v));
//       });
//     }
//     markerPrice = json['marker_price'];
//     markerDate = json['marker_date'];
//     showFeatured = json['show_featured'];
//     shareLink = json['share_link'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['lat_event'] = this.latEvent;
//     data['lng_event'] = this.lngEvent;
//     data['title'] = this.title;
//     if (this.date != null) {
//       data['date'] = this.date!.toJson();
//     }
//     data['average_rating'] = this.averageRating;
//     data['number_comment'] = this.numberComment;
//     data['thumbnail_event'] = this.thumbnailEvent;
//     data['address'] = this.address;
//     data['distance'] = this.distance;
//     data['date1'] = this.date1;
//     data['price_jk'] = this.priceJk;
//     data['ticket_rest'] = this.ticketRest;
//     if (this.categoryData != null) {
//       data['category_data'] =
//           this.categoryData!.map((v) => v.toJson()).toList();
//     }
//     data['marker_price'] = this.markerPrice;
//     data['marker_date'] = this.markerDate;
//     data['show_featured'] = this.showFeatured;
//     data['share_link'] = this.shareLink;
//     return data;
//   }
// }

// class Date {
//   String? day;
//   String? startTime;
//   String? dayNo;
//   String? month;

//   Date({this.day, this.startTime, this.dayNo, this.month});

//   Date.fromJson(Map<String, dynamic> json) {
//     day = json['day'];
//     startTime = json['start_time'];
//     dayNo = json['day_no'];
//     month = json['month'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['day'] = this.day;
//     data['start_time'] = this.startTime;
//     data['day_no'] = this.dayNo;
//     data['month'] = this.month;
//     return data;
//   }
// }

// class CategoryData {
//   String? name;
//   String? color;

//   CategoryData({this.name, this.color});

//   CategoryData.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     color = json['color'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['color'] = this.color;
//     return data;
//   }
// }

class HomeData {
  int? success;
  List<Data>? data;
  int? countEvent;
  dynamic error;

  HomeData({this.success, this.data, this.countEvent, this.error});

  HomeData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        // ome(v);
        // print("chetan json data check");

        data!.add(new Data.fromJson(v));
      });
    }
    countEvent = json['count_event'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count_event'] = this.countEvent;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? id;
  String? latEvent;
  String? lngEvent;
  String? title;
  Date? date;
  dynamic averageRating;
  int? numberComment;
  String? thumbnailEvent;
  String? address;
  dynamic distance;
  String? date1;
  String? priceJk;
  String? ticketRest;
  List<CategoryData>? categoryData;
  String? markerPrice;
  String? markerDate;
  String? showFeatured;
  String? shareLink;
  int? customView;

  Data(
      {this.id,
      this.latEvent,
      this.lngEvent,
      this.title,
      this.date,
      this.averageRating,
      this.numberComment,
      this.thumbnailEvent,
      this.address,
      this.distance,
      this.date1,
      this.priceJk,
      this.ticketRest,
      this.categoryData,
      this.markerPrice,
      this.markerDate,
      this.showFeatured,
      this.shareLink,
      this.customView});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latEvent = json['lat_event'];
    lngEvent = json['lng_event'];
    title = json['title'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;

    averageRating = json['average_rating'];
    numberComment = json['number_comment'];
    thumbnailEvent = json['thumbnail_event'];
    address = json['address'];
    distance = json['distance'];
    date1 = json['date1'];
    priceJk = json['price_jk'];
    ticketRest = json['ticket_rest'];
    if (json['category_data'] != null) {
      categoryData = <CategoryData>[];
      json['category_data'].forEach((v) {
        categoryData!.add(new CategoryData.fromJson(v));
      });
    }
    markerPrice = json['marker_price'];
    markerDate = json['marker_date'];
    showFeatured = json['show_featured'];
    shareLink = json['share_link'];
    customView = json['custom_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat_event'] = this.latEvent;
    data['lng_event'] = this.lngEvent;
    data['title'] = this.title;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    data['average_rating'] = this.averageRating;
    data['number_comment'] = this.numberComment;
    data['thumbnail_event'] = this.thumbnailEvent;
    data['address'] = this.address;
    data['distance'] = this.distance;
    data['date1'] = this.date1;
    data['price_jk'] = this.priceJk;
    data['ticket_rest'] = this.ticketRest;
    if (this.categoryData != null) {
      data['category_data'] =
          this.categoryData!.map((v) => v.toJson()).toList();
    }
    data['marker_price'] = this.markerPrice;
    data['marker_date'] = this.markerDate;
    data['show_featured'] = this.showFeatured;
    data['share_link'] = this.shareLink;
    data['custom_view'] = this.customView;

    return data;
  }
}

class Date {
  String? day;
  String? startTime;
  String? dayNo;
  String? month;

  Date({this.day, this.startTime, this.dayNo, this.month});

  Date.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    startTime = json['start_time'];
    dayNo = json['day_no'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['start_time'] = this.startTime;
    data['day_no'] = this.dayNo;
    data['month'] = this.month;
    return data;
  }
}

class CategoryData {
  String? name;
  String? color;

  CategoryData({this.name, this.color});

  CategoryData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}
