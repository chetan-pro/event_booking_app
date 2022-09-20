// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
    result: Result.fromJson(json["result"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "html_attributions": List<dynamic>.from(htmlAttributions!.map((x) => x)),
    "result": result?.toJson(),
    "status": status,
  };
}

class Result {
  Result({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  List<AddressComponent>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  String? formattedAddress;
  String? formattedPhoneNumber;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? internationalPhoneNumber;
  String? name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String? placeId;
  PlusCode? plusCode;
  double? rating;
  String? reference;
  List<Review>? reviews;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;
  String? website;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
    adrAddress: json["adr_address"],
    businessStatus: json["business_status"],
    formattedAddress: json["formatted_address"],
    formattedPhoneNumber: json["formatted_phone_number"],
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    iconBackgroundColor: json["icon_background_color"],
    iconMaskBaseUri: json["icon_mask_base_uri"],
    internationalPhoneNumber: json["international_phone_number"],
    name: json["name"],
    // openingHours: OpeningHours.fromJson(json["opening_hours"]),
    // photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    placeId: json["place_id"],
    // plusCode: PlusCode.fromJson(json["plus_code"]),
    // rating: json["rating"].toDouble(),
    reference: json["reference"],
    // reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    types: List<String>.from(json["types"].map((x) => x)),
    url: json["url"],
    userRatingsTotal: json["user_ratings_total"],
    utcOffset: json["utc_offset"],
    vicinity: json["vicinity"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "address_components": List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
    "adr_address": adrAddress,
    "business_status": businessStatus,
    "formatted_address": formattedAddress,
    "formatted_phone_number": formattedPhoneNumber,
    "geometry": geometry?.toJson(),
    "icon": icon,
    "icon_background_color": iconBackgroundColor,
    "icon_mask_base_uri": iconMaskBaseUri,
    "international_phone_number": internationalPhoneNumber,
    "name": name,
    "opening_hours": openingHours?.toJson(),
    "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
    "place_id": placeId,
    "plus_code": plusCode?.toJson(),
    "rating": rating,
    "reference": reference,
    "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "types": List<dynamic>.from(types!.map((x) => x)),
    "url": url,
    "user_ratings_total": userRatingsTotal,
    "utc_offset": utcOffset,
    "vicinity": vicinity,
    "website": website,
  };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
    longName: json["long_name"],
    shortName: json["short_name"],
    types: List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "long_name": longName,
    "short_name": shortName,
    "types": List<dynamic>.from(types!.map((x) => x)),
  };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  LocationClass? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: LocationClass.fromJson(json["location"]),
    viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "viewport": viewport?.toJson(),
  };
}

class LocationClass {
  LocationClass({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory LocationClass.fromJson(Map<String, dynamic> json) => LocationClass(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  LocationClass? northeast;
  LocationClass? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: LocationClass.fromJson(json["northeast"]),
    southwest: LocationClass.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast?.toJson(),
    "southwest": southwest?.toJson(),
  };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  bool? openNow;
  List<Period>? periods;
  List<String>? weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    openNow: json["open_now"],
    periods: List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
    weekdayText: List<String>.from(json["weekday_text"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow,
    "periods": List<dynamic>.from(periods!.map((x) => x.toJson())),
    "weekday_text": List<dynamic>.from(weekdayText!.map((x) => x)),
  };
}

class Period {
  Period({
    this.close,
    this.open,
  });

  Close? close;
  Close? open;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    close: Close.fromJson(json["close"]),
    open: Close.fromJson(json["open"]),
  );

  Map<String, dynamic> toJson() => {
    "close": close?.toJson(),
    "open": open?.toJson(),
  };
}

class Close {
  Close({
    this.day,
    this.time,
  });

  int? day;
  String? time;

  factory Close.fromJson(Map<String, dynamic> json) => Close(
    day: json["day"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "time": time,
  };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    height: json["height"],
    htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "html_attributions": List<dynamic>.from(htmlAttributions!.map((x) => x)),
    "photo_reference": photoReference,
    "width": width,
  };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"],
    globalCode: json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode,
    "global_code": globalCode,
  };
}

class Review {
  Review({
    this.authorName,
    this.authorUrl,
    this.language,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  String? authorName;
  String? authorUrl;
  String? language;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    authorName: json["author_name"],
    authorUrl: json["author_url"],
    language: json["language"],
    profilePhotoUrl: json["profile_photo_url"],
    rating: json["rating"],
    relativeTimeDescription: json["relative_time_description"],
    text: json["text"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "author_name": authorName,
    "author_url": authorUrl,
    "language": language,
    "profile_photo_url": profilePhotoUrl,
    "rating": rating,
    "relative_time_description": relativeTimeDescription,
    "text": text,
    "time": time,
  };
}
