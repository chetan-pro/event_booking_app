// To parse this JSON data, do
//
//     final createEditEvents = createEditEventsFromJson(jsonString);

import 'dart:convert';

CreateEditEvents createEditEventsFromJson(String str) => CreateEditEvents.fromJson(json.decode(str));

String createEditEventsToJson(CreateEditEvents data) => json.encode(data.toJson());

class CreateEditEvents {
  CreateEditEvents({
    this.success,
    this.data,
    this.error,
  });

  int? success;
  Data? data;
  dynamic error;

  factory CreateEditEvents.fromJson(Map<String, dynamic> json) => CreateEditEvents(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "error": error,
  };
}

class Data {
  Data({
    this.id,
    this.postAuthor,
    this.postDate,
    this.postDateGmt,
    this.postContent,
    this.postTitle,
    this.postExcerpt,
    this.postStatus,
    this.commentStatus,
    this.pingStatus,
    this.postPassword,
    this.postName,
    this.toPing,
    this.pinged,
    this.postModified,
    this.postModifiedGmt,
    this.postContentFiltered,
    this.postParent,
    this.guid,
    this.menuOrder,
    this.postType,
    this.postMimeType,
    this.commentCount,
    this.filter,
    this.procom,
    this.nextTab,
    this.ovaMbEventPostId,
    this.ovaMbEventUserId,
    this.ovaMbEventNameEvent,
    this.ovaMbEventEventType,
    this.ovaMbEventContentEvent,
    this.ovaMbEventEventCat,
    this.ovaMbEventAddress,
    this.ovaMbEventMapLat,
    this.ovaMbEventMapLng,
    this.ovaMbEventMapAddress,
    this.ovaMbEventImgThumbnail,
    this.ovaMbEventLinkVideo,
    this.ovaMbEventSingleBanner,
    this.ovaMbEventOptionCalendar,
    this.ovaMbEventIsFinalPage,
    this.ovaMbEventNextTab,
    this.ovaMbEventEventTax,
    this.ovaMbEventSocialOrganizer,
    this.ovaMbEventGallery,
    this.ovaMbEventImageBanner,
    this.ovaMbEventTicket,
    this.ovaMbEventCalendar,
    this.ovaMbEventSchedulesTime,
    this.ovaMbEventDisableDate,
    this.ovaMbEventCoupon,
    this.ovaMbEventVenue,
    this.ovaMbEventRecurrenceBydays,
    this.ovaMbEventRecurrenceInterval,
    this.ovaMbEventInfoOrganizer,
    this.ovaMbEventEditFullAddress,
    this.ovaMbEventCalendarRecurrence,
    this.ovaMbEventEventDays,
    this.ovaMbEventStartDateStr,
    this.ovaMbEventEndDateStr,
    this.ovaMbEventEventActive,
    this.thumbnailId,
    this.ovaMbEventPackage,
    this.ovaMbEventStatusPay,
  });

  int? id;
  String? postAuthor;
  DateTime? postDate;
  String? postDateGmt;
  String? postContent;
  String? postTitle;
  String? postExcerpt;
  String? postStatus;
  String? commentStatus;
  String? pingStatus;
  String? postPassword;
  String? postName;
  String? toPing;
  String? pinged;
  DateTime? postModified;
  String? postModifiedGmt;
  String? postContentFiltered;
  int? postParent;
  String? guid;
  int? menuOrder;
  String? postType;
  String? postMimeType;
  String? commentCount;
  String? filter;
  String? procom;
  String? nextTab;
  String? ovaMbEventPostId;
  String? ovaMbEventUserId;
  String? ovaMbEventNameEvent;
  String? ovaMbEventEventType;
  String? ovaMbEventContentEvent;
  String? ovaMbEventEventCat;
  String? ovaMbEventAddress;
  String? ovaMbEventMapLat;
  String? ovaMbEventMapLng;
  String? ovaMbEventMapAddress;
  String? ovaMbEventImgThumbnail;
  String? ovaMbEventLinkVideo;
  String? ovaMbEventSingleBanner;
  String? ovaMbEventOptionCalendar;
  String? ovaMbEventIsFinalPage;
  String? ovaMbEventNextTab;
  String? ovaMbEventEventTax;
  String? ovaMbEventSocialOrganizer;
  String? ovaMbEventGallery;
  String? ovaMbEventImageBanner;
  String? ovaMbEventTicket;
  String? ovaMbEventCalendar;
  String? ovaMbEventSchedulesTime;
  String? ovaMbEventDisableDate;
  String? ovaMbEventCoupon;
  String? ovaMbEventVenue;
  String? ovaMbEventRecurrenceBydays;
  String? ovaMbEventRecurrenceInterval;
  String? ovaMbEventInfoOrganizer;
  String? ovaMbEventEditFullAddress;
  String? ovaMbEventCalendarRecurrence;
  String? ovaMbEventEventDays;
  String? ovaMbEventStartDateStr;
  String? ovaMbEventEndDateStr;
  String? ovaMbEventEventActive;
  String? thumbnailId;
  String? ovaMbEventPackage;
  String? ovaMbEventStatusPay;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    postAuthor: json["post_author"],
    postDate: DateTime.parse(json["post_date"]),
    postDateGmt: json["post_date_gmt"],
    postContent: json["post_content"],
    postTitle: json["post_title"],
    postExcerpt: json["post_excerpt"],
    postStatus: json["post_status"],
    commentStatus: json["comment_status"],
    pingStatus: json["ping_status"],
    postPassword: json["post_password"],
    postName: json["post_name"],
    toPing: json["to_ping"],
    pinged: json["pinged"],
    postModified: DateTime.parse(json["post_modified"]),
    postModifiedGmt: json["post_modified_gmt"],
    postContentFiltered: json["post_content_filtered"],
    postParent: json["post_parent"],
    guid: json["guid"],
    menuOrder: json["menu_order"],
    postType: json["post_type"],
    postMimeType: json["post_mime_type"],
    commentCount: json["comment_count"],
    filter: json["filter"],
    procom: json["procom"],
    nextTab: json["next_tab"],
    ovaMbEventPostId: json["ova_mb_event_post_id"],
    ovaMbEventUserId: json["ova_mb_event_user_id"],
    ovaMbEventNameEvent: json["ova_mb_event_name_event"],
    ovaMbEventEventType: json["ova_mb_event_event_type"],
    ovaMbEventContentEvent: json["ova_mb_event_content_event"],
    ovaMbEventEventCat: json["ova_mb_event_event_cat"],
    ovaMbEventAddress: json["ova_mb_event_address"],
    ovaMbEventMapLat: json["ova_mb_event_map_lat"],
    ovaMbEventMapLng: json["ova_mb_event_map_lng"],
    ovaMbEventMapAddress: json["ova_mb_event_map_address"],
    ovaMbEventImgThumbnail: json["ova_mb_event_img_thumbnail"],
    ovaMbEventLinkVideo: json["ova_mb_event_link_video"],
    ovaMbEventSingleBanner: json["ova_mb_event_single_banner"],
    ovaMbEventOptionCalendar: json["ova_mb_event_option_calendar"],
    ovaMbEventIsFinalPage: json["ova_mb_event_is_final_page"],
    ovaMbEventNextTab: json["ova_mb_event_next_tab"],
    ovaMbEventEventTax: json["ova_mb_event_event_tax"],
    ovaMbEventSocialOrganizer: json["ova_mb_event_social_organizer"],
    ovaMbEventGallery: json["ova_mb_event_gallery"],
    ovaMbEventImageBanner: json["ova_mb_event_image_banner"],
    ovaMbEventTicket: json["ova_mb_event_ticket"],
    ovaMbEventCalendar: json["ova_mb_event_calendar"],
    ovaMbEventSchedulesTime: json["ova_mb_event_schedules_time"],
    ovaMbEventDisableDate: json["ova_mb_event_disable_date"],
    ovaMbEventCoupon: json["ova_mb_event_coupon"],
    ovaMbEventVenue: json["ova_mb_event_venue"],
    ovaMbEventRecurrenceBydays: json["ova_mb_event_recurrence_bydays"],
    ovaMbEventRecurrenceInterval: json["ova_mb_event_recurrence_interval"],
    ovaMbEventInfoOrganizer: json["ova_mb_event_info_organizer"],
    ovaMbEventEditFullAddress: json["ova_mb_event_edit_full_address"],
    ovaMbEventCalendarRecurrence: json["ova_mb_event_calendar_recurrence"],
    ovaMbEventEventDays: json["ova_mb_event_event_days"],
    ovaMbEventStartDateStr: json["ova_mb_event_start_date_str"],
    ovaMbEventEndDateStr: json["ova_mb_event_end_date_str"],
    ovaMbEventEventActive: json["ova_mb_event_event_active"],
    thumbnailId: json["_thumbnail_id"],
    ovaMbEventPackage: json["ova_mb_event_package"],
    ovaMbEventStatusPay: json["ova_mb_event_status_pay"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "post_author": postAuthor,
    "post_date": postDate?.toIso8601String(),
    "post_date_gmt": postDateGmt,
    "post_content": postContent,
    "post_title": postTitle,
    "post_excerpt": postExcerpt,
    "post_status": postStatus,
    "comment_status": commentStatus,
    "ping_status": pingStatus,
    "post_password": postPassword,
    "post_name": postName,
    "to_ping": toPing,
    "pinged": pinged,
    "post_modified": postModified?.toIso8601String(),
    "post_modified_gmt": postModifiedGmt,
    "post_content_filtered": postContentFiltered,
    "post_parent": postParent,
    "guid": guid,
    "menu_order": menuOrder,
    "post_type": postType,
    "post_mime_type": postMimeType,
    "comment_count": commentCount,
    "filter": filter,
    "procom": procom,
    "next_tab": nextTab,
    "ova_mb_event_post_id": ovaMbEventPostId,
    "ova_mb_event_user_id": ovaMbEventUserId,
    "ova_mb_event_name_event": ovaMbEventNameEvent,
    "ova_mb_event_event_type": ovaMbEventEventType,
    "ova_mb_event_content_event": ovaMbEventContentEvent,
    "ova_mb_event_event_cat": ovaMbEventEventCat,
    "ova_mb_event_address": ovaMbEventAddress,
    "ova_mb_event_map_lat": ovaMbEventMapLat,
    "ova_mb_event_map_lng": ovaMbEventMapLng,
    "ova_mb_event_map_address": ovaMbEventMapAddress,
    "ova_mb_event_img_thumbnail": ovaMbEventImgThumbnail,
    "ova_mb_event_link_video": ovaMbEventLinkVideo,
    "ova_mb_event_single_banner": ovaMbEventSingleBanner,
    "ova_mb_event_option_calendar": ovaMbEventOptionCalendar,
    "ova_mb_event_is_final_page": ovaMbEventIsFinalPage,
    "ova_mb_event_next_tab": ovaMbEventNextTab,
    "ova_mb_event_event_tax": ovaMbEventEventTax,
    "ova_mb_event_social_organizer": ovaMbEventSocialOrganizer,
    "ova_mb_event_gallery": ovaMbEventGallery,
    "ova_mb_event_image_banner": ovaMbEventImageBanner,
    "ova_mb_event_ticket": ovaMbEventTicket,
    "ova_mb_event_calendar": ovaMbEventCalendar,
    "ova_mb_event_schedules_time": ovaMbEventSchedulesTime,
    "ova_mb_event_disable_date": ovaMbEventDisableDate,
    "ova_mb_event_coupon": ovaMbEventCoupon,
    "ova_mb_event_venue": ovaMbEventVenue,
    "ova_mb_event_recurrence_bydays": ovaMbEventRecurrenceBydays,
    "ova_mb_event_recurrence_interval": ovaMbEventRecurrenceInterval,
    "ova_mb_event_info_organizer": ovaMbEventInfoOrganizer,
    "ova_mb_event_edit_full_address": ovaMbEventEditFullAddress,
    "ova_mb_event_calendar_recurrence": ovaMbEventCalendarRecurrence,
    "ova_mb_event_event_days": ovaMbEventEventDays,
    "ova_mb_event_start_date_str": ovaMbEventStartDateStr,
    "ova_mb_event_end_date_str": ovaMbEventEndDateStr,
    "ova_mb_event_event_active": ovaMbEventEventActive,
    "_thumbnail_id": thumbnailId,
    "ova_mb_event_package": ovaMbEventPackage,
    "ova_mb_event_status_pay": ovaMbEventStatusPay,
  };
}
