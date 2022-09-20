import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class CreateEventNetwork {
  CreateEventNetwork({
    this.imagePath,
    this.filename,
    this.nameEventController,
    this.categoryController,
    this.eventContentController,
    this.addressController,
    this.videoController,
    this.ticketDescriptionController,
    this.totalTicketController,
    this.ticketPriceController,
    this.discountAmountController,
    this.discountCodeController,
    this.recurrenceByDaysController,
    this.recurrenceFrequencyController,
    this.recurrenceIntervalController,
    this.endTimeController,
    this.startTimeController,
    this.optionCalenderController,
    this.userImage,
    this.userDescription,
    this.userPhoneController,
    this.userAddressController,
    this.bankBranchController,
    this.bankNameController,
    this.bankNumberController,
    this.bankOwnerController,
    this.galleryImages,
    this.lastnameController,
    this.firstnameController,
    this.calendarRecurrenceBookBefore,
    this.selectCategory,
    this.calenderEndDate,
    this.calenderStartDate,
    this.isSaturday,
    this.isFriday,
    this.isThursday,
    this.isWednesday,
    this.isTuesday,
    this.isMonday,
    this.isSunday,
    this.eventID,
    this.disableEndDate,
    this.disableStartDate,
    this.latitude,
    this.longitude,
  });

  String? nameEventController;
  String? categoryController;
  String? selectCategory;
  String? eventContentController;
  String? addressController;
  String? videoController;
  dynamic imagePath;
  dynamic filename;
  List<MultipartFile>? galleryImages;
  dynamic latitude;
  dynamic longitude;

  //
  String? ticketPriceController;
  String? totalTicketController;
  String? ticketDescriptionController;
  String? discountCodeController;
  String? discountAmountController;

//
  String? optionCalenderController;
  String? startTimeController;
  String? endTimeController;
  String? recurrenceIntervalController;
  String? recurrenceFrequencyController;
  String? recurrenceByDaysController;
  String? calendarRecurrenceBookBefore;
  String? calenderStartDate;
  String? calenderEndDate;
  String? disableStartDate;
  String? disableEndDate;

  //
  String? isMonday;
  String? isTuesday;
  String? isWednesday;
  String? isThursday;
  String? isFriday;
  String? isSaturday;
  String? isSunday;

//
  String? firstnameController;
  String? lastnameController;
  String? userAddressController;
  String? userPhoneController;
  String? userDescription;
  String? userImage;

//
  String? bankOwnerController;
  String? bankNumberController;
  String? bankNameController;
  String? bankBranchController;

  int? eventID;

  String? dobManual;

//create event general---------
  Future postCreateEventsGeneral(
      BuildContext context, userid, postID, deleteImage) async {
    try {
      var response = await ApiProvider.post(
        url: 'create_edit_event_general',
        body: {
          'post_id': postID,
          'user_id': userid,
          'name_event': "$nameEventController",
          'event_type': categoryController ?? 'classic',
          'event_cat': "$selectCategory",
          'content_event': "$eventContentController",
          'map_address': "$addressController",
          'map_lat': "$latitude",
          'map_lng': "$longitude",
          'single_banner': 'thumbnail',
          'option_calendar': 'auto',
          'next_tab': 'mb_ticket',
        },
      );

      EasyLoading.dismiss();
      print('post create event chala post create event chala');
      print(response['body']['data']['ID'].runtimeType);
      eventID = response['body']['data']['ID'];
      if (response['status'] == 200) {}
    } catch (e) {
      print('createEventcreateEventcreateEvent${e}');
      EasyLoading.dismiss();
    }
  }

  Future postCreateEventsMedia(
      BuildContext context,
      eventIdEdit,
      imagePath,
      filename,
      videoController,
      deleteImage,
      List<MultipartFile>? galleryImages) async {
    try {
      print('-=-=-=-=-=-');
      print(galleryImages);
      // EasyLoading.dismiss();
      // return;

      final response = await ApiProvider.post(
        url: 'create_edit_event_media',
        body: {
          'event_id': eventID ?? eventIdEdit,
          'link_video': "$videoController",
          'thumbnail': imagePath != null
              ? await MultipartFile.fromFile(imagePath, filename: filename)
              : '',
          if (galleryImages!.isNotEmpty) 'event_gallery[]': galleryImages,
          'delete_gallery_img': "$deleteImage",
        },
      );
      EasyLoading.dismiss();
      print('post create event chala post create event chala');
      print(response['body']['data']['ID'].runtimeType);
      eventID = response['body']['data']['ID'];
    } catch (e) {
      print('createEventcreateEventcreateEvent${e}');
      EasyLoading.dismiss();
    }
  }

//create event TICKET---------

  Future postCreateEventsTicket(
    BuildContext context,
    List<TextEditingController> ticketPriceController,
    List<TextEditingController> totalTicketController,
    List<TextEditingController> ticketDescriptionController,
    eventIdEdit,
    List<TextEditingController> nameTicket,
    List ticketID,
  ) async {
    try {
      final response = await ApiProvider.post(
        url: 'create_edit_event_ticket',
        body: {
          'event_id': "${eventIdEdit ?? eventID}",
          for (int i = 0; i < ticketPriceController.length; i++)
            'ticket[$i][price_ticket]': ticketPriceController[i].text,
          for (int i = 0; i < totalTicketController.length; i++)
            'ticket[$i][number_total_ticket]': totalTicketController[i].text,
          for (int i = 0; i < ticketDescriptionController.length; i++)
            'ticket[$i][private_desc_ticket]':
                ticketDescriptionController[i].text,
          for (int i = 0; i < ticketPriceController.length; i++)
            'ticket[$i][number_min_ticket]': "1",
          for (int i = 0; i < ticketPriceController.length; i++)
            'ticket[$i][number_max_ticket]': "10",
          if (eventIdEdit != null)
            for (int i = 0; i < ticketID.length; i++)
              'ticket[$i][ticket_id]': "${ticketID[i].ticketId}",
          for (int i = 0; i < nameTicket.length; i++)
            'ticket[$i][name_ticket]': nameTicket[i].text,
          for (int i = 0; i < ticketPriceController.length; i++)
            'ticket[$i][type_price]': "paid",
        },
      );
      print('post tickettttt event chala post create event chala');
      print(ticketPriceController);
      print(ticketPriceController.length);
      print('post tickettttt event chala post create event chala');
      print(response);
      EasyLoading.dismiss();
    } catch (e) {
      print('tickettttttt${e}');
    }
  }

  Future postCreateEventsTicketCoupon(BuildContext context,
      discountCodeController, discountAmountController, eventIdEdit) async {
    try {
      final response =
          await ApiProvider.post(url: 'create_event_discount', body: {
        'event_id': "${eventIdEdit ?? eventID}",
        'discount_code': "$discountCodeController",
        'discount_amout_number': "$discountAmountController",
      });
      print('post discooounbt event chala post create event chala');
      print(response);
    } catch (e) {
      print('tickettttttt${e}');
    }
  }

//create postCreateEventsCalender----------
  Future postCreateEventsCalender(
    BuildContext context,
    optionCalenderController,
    startTimeController,
    endTimeController,
    calenderStartDate,
    recurrenceIntervalController,
    recurrenceFrequencyController,
    isSunday,
    isMonday,
    isTuesday,
    isWednesday,
    isThursday,
    isFriday,
    isSaturday,
    calendarRecurrenceBookBefore,
    List<TextEditingController> calendarRecurrenceBookBeforeManual,
    disableStartDate,
    disableEndDate,
    eventIdEdit,
    List dobManual,
    List startTimeManual,
    List endTimeManual,
  ) async {
    try {
      final response = await ApiProvider.post(
          url: 'create_edit_event_activity_times',
          body: {
            'event_id': "${eventIdEdit ?? eventID}",
            'option_calendar': optionCalenderController,
            if (optionCalenderController == 'auto')
              'start_time': "$startTimeController",
            if (optionCalenderController == 'auto')
              'end_time': "$endTimeController",
            if (optionCalenderController == 'auto')
              'calendar_start_date': "$calenderStartDate",
            if (optionCalenderController == 'auto')
              'calendar_end_date': "01-01-2030",
            if (optionCalenderController == 'auto')
              'recurrence_interval': "$recurrenceIntervalController",
            if (optionCalenderController == 'auto')
              'recurrence_frequency': "weekly",
            if (optionCalenderController == 'auto' && isSunday != null)
              'recurrence_bydays[0]': "$isSunday",
            if (optionCalenderController == 'auto' && isMonday != null)
              'recurrence_bydays[1]': "$isMonday",
            if (optionCalenderController == 'auto' && isTuesday != null)
              'recurrence_bydays[2]': "$isTuesday",
            if (optionCalenderController == 'auto' && isWednesday != null)
              'recurrence_bydays[3]': "$isWednesday",
            if (optionCalenderController == 'auto' && isThursday != null)
              'recurrence_bydays[4]': "$isThursday",
            if (optionCalenderController == 'auto' && isFriday != null)
              'recurrence_bydays[5]': "$isFriday",
            if (optionCalenderController == 'auto' && isSaturday != null)
              'recurrence_bydays[6]': "$isSaturday",
            if (optionCalenderController == 'auto')
              'calendar_recurrence_book_before':
                  "$calendarRecurrenceBookBefore",
            if (optionCalenderController == 'auto')
              'disable_date[0][end_date]': "$disableEndDate",
            if (optionCalenderController == 'auto')
              'disable_date[0][start_date]': "$disableStartDate",
            if (optionCalenderController == 'manual')
              for (int i = 0; i < dobManual.length; i++)
                'calendar[$i][date]': "${dobManual[i]}",
            if (optionCalenderController == 'manual')
              for (int i = 0; i < dobManual.length; i++)
                'calendar[$i][end_date]': "${dobManual[i]}",
            if (optionCalenderController == 'manual')
              for (int i = 0; i < endTimeManual.length; i++)
                'calendar[$i][start_time]': "${endTimeManual[i]}",
            if (optionCalenderController == 'manual')
              for (int i = 0; i < startTimeManual.length; i++)
                'calendar[$i][end_time]': "${startTimeManual[i]}",
            if (optionCalenderController == 'manual')
              for (int i = 0; i < dobManual.length; i++)
                'calendar[$i][book_before_minutes]':
                    "${calendarRecurrenceBookBeforeManual[i].text}",
          });
      print('postCreateEventsCalender postCreateEventsCalender chala');
      EasyLoading.dismiss();
      print(dobManual);
      print(response);
    } catch (e) {
      EasyLoading.dismiss();
      print('postCreateEventsCalenderpostCreateEventsCalender${e}');
    }
  }

  // update user profile

  // Future postCreateEventsUpdateProfile(
  //     BuildContext context,
  //     userID,
  //     firstnameController,
  //     lastnameController,
  //     userAddressController,
  //     userPhoneController,
  //     userDescription,
  //     userImage)
  //     async {
  //   try {
  //     final response =
  //         await ApiProvider.post(url: 'update_user_profile', body: {
  //       'user_id': userID,
  //       'first_name': "$firstnameController",
  //       'last_name': "$lastnameController",
  //       'user_address': "$userAddressController",
  //       'user_phone': "$userPhoneController",
  //       'description': "$userDescription",
  //       'image_id': "$userImage",
  //       "author_img":$autherImage
  //     });
  //     print('postCreateEventsCalender postCreateEventsCalender chala');
  //     EasyLoading.dismiss();
  //     print(response);
  //   } catch (e) {
  //     print('tickettttttt${e}');
  //   }
  // }

  Future postCreateEventsUserPayment(
      BuildContext context,
      userID,
      bankOwnerController,
      bankNumberController,
      bankNameController,
      bankBranchController) async {
    try {
      final response =
          await ApiProvider.post(url: 'update_user_payout_method', body: {
        "user_id": userID,
        'user_bank_owner': "$bankOwnerController",
        'user_bank_number': "$bankNumberController",
        'user_bank_name': "$bankNameController",
        'user_bank_branch': "$bankBranchController",
      });
      print('postCreateEventsCalender bank postCreateEventsCalender chala');
      print(userID);
      print(bankOwnerController);
      print(bankNumberController);
      print(bankNameController);
      print(bankBranchController);
      print(response);
      errorAlertMessage('errorMessage', context);
      EasyLoading.dismiss();
    } catch (e) {
      print('tickettttttt${e}');
    }
  }

  void errorAlertMessage(String errorMessage, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: Center(
            child: const Text(
          'תודה לכם על הוספת הפעילות!',
          textDirection: TextDirection.rtl,
        )),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'אנחנו נעבור על הפעילות שלכם ונשלח לכם אימייל ברגע שהפעילות תאושר!',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center),
              Text(
                'ניתן לערוך את הפעילות בכל עת דרך:',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              Text('החשבון שלי >> הפעילויות שלי',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen())),
            child: Center(child: const Text('אישור')),
          ),
        ],
      ),
    );
  }
}
