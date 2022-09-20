import 'package:basalon/modal/discount_model.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:basalon/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../screens/home_screen.dart';

class PlaceOrderNetwork {
  PlaceOrderNetwork(
      {this.userPhone,
      this.userId,
      this.userEmail,
      this.userAddress,
      this.userFullname,
      this.ticketId,
      this.totalAmount,
      this.numOfTicket,
      this.productId,
      this.beginningTime,
      this.bookingDate,
      this.mobNumber,
      this.moreDetails,
      this.numOfParticipants,
      this.totalAfterTax,
      this.eventTax,
      this.couponAmount,
      this.couponCode,
      this.formatDate});

  int? userId;
  int? productId;
  List? ticketId;
  List? numOfTicket;
  String? userFullname;
  String? userEmail;
  String? userPhone;
  String? userAddress;
  List? totalAmount;

  String? bookingDate;
  String? beginningTime;
  String? numOfParticipants;
  String? mobNumber;
  String? moreDetails;

  String? couponCode;
  String? couponAmount;
  String? eventTax;
  String? totalAfterTax;
  String? formatDate;

  DiscountModel? discountModel;

  Future placeOrder(
    BuildContext context,
    bool newsletter,
  ) async {
    try {
      final response = await ApiProvider.post(
        url: 'place_order',
        body: {
          "user_id": "$userId",
          "event_id": "$productId",
          "booking_date": formatDate,
          "first_name": "${userFullname?.split(' ').first}",
          "last_name": "${userFullname?.split(' ').last}",
          "email": "$userEmail",
          "phone": "$userPhone",
          "payment_method": "woo",
          "coupon": "$couponCode",
          for (int i = 0; i < ticketId!.length; i++)
            "cart[$i][id]": "${ticketId?[i].ticketId}",
          for (int i = 0; i < ticketId!.length; i++)
            "cart[$i][name]": "${ticketId?[i].nameTicket}",
          for (int i = 0; i < totalAmount!.length; i++)
            "cart[$i][price]": "${totalAmount?[i]}",
          for (int i = 0; i < numOfTicket!.length; i++)
            "cart[$i][qty]": "${numOfTicket?[i]}",
          "newsletter": "$newsletter",

          // "ticket_receiver_address": "$userAddress",
          // "billing_company": "test",
          // "billing_city": "jerusalem",
          // "billing_country": "israel",
          // "billing_address_1": "$userAddress",
          // "billing_address_2": "$userAddress",
          // "billing_postcode": "9103401",
          // "billing_phone": "$userPhone",
          // "billing_email": "$userEmail",
          // "qty": "$numOfTicket",
          // "subtotal": "$totalAmount",
          // "total": "$totalAmount",
          // "ticket_id": "$ticketId",
          // "event_commission": "$couponAmount",
          // "event_tax": "$eventTax",
          // "total_after_tax": "$totalAmount",
        },
      );
      print('place order chala place order chala place order chala');
      print(response['body']);
      print(formatDate);
      print(ticketId);
      print(totalAmount);
      print(numOfTicket);
      print(response);
      errorAlertMessage(context);
      EasyLoading.dismiss();
    } catch (e) {
      print('${e} failed order');
      EasyLoading.dismiss();
    }
  }

  static Future placeOrders(
    BuildContext context,
    bool newsletter, {
    userId,
    productId,
    formatDate,
    fname,
    lname,
    userEmail,
    userPhone,
    couponCode,
    ticketId,
    totalAmount,
    numOfTicket,
  }) async {
    print(userId);
    print('userId');
    try {
      //EasyLoading.show();
      final response = await ApiProvider.post(
        url: 'place_order',
        body: {
          "user_id": "$userId",
          "event_id": "$productId",
          "booking_date": formatDate,
          "first_name": fname,
          "last_name": lname,
          "email": "$userEmail",
          "phone": "$userPhone",
          "payment_method": "woo",
          "coupon": "$couponCode",
          for (int i = 0; i < ticketId!.length; i++)
            "cart[$i][id]": "${ticketId?[i].ticketId}",
          for (int i = 0; i < ticketId!.length; i++)
            "cart[$i][name]": "${ticketId?[i].nameTicket}",
          for (int i = 0; i < totalAmount!.length; i++)
            "cart[$i][price]": "${totalAmount?[i]}",
          for (int i = 0; i < numOfTicket!.length; i++)
            "cart[$i][qty]": "${numOfTicket?[i]}",
          "newsletter": "$newsletter",

          // "ticket_receiver_address": "$userAddress",
          // "billing_company": "test",
          // "billing_city": "jerusalem",
          // "billing_country": "israel",
          // "billing_address_1": "$userAddress",
          // "billing_address_2": "$userAddress",
          // "billing_postcode": "9103401",
          // "billing_phone": "$userPhone",
          // "billing_email": "$userEmail",
          // "qty": "$numOfTicket",
          // "subtotal": "$totalAmount",
          // "total": "$totalAmount",
          // "ticket_id": "$ticketId",
          // "event_commission": "$couponAmount",
          // "event_tax": "$eventTax",
          // "total_after_tax": "$totalAmount",
        },
      );
      print('place order chala place order chala place order chala');
      print(response['body']);
      print(formatDate);
      print(ticketId);
      print(totalAmount);
      print(numOfTicket);
      print(response);
      EasyLoading.dismiss();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          contentPadding: EdgeInsets.zero,
          title: const Center(
              child: Text(
            'תודה על הזמנתכם!',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 24),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'שלחנו את הכרטיסים לאימייל שלכם.',
                style: ktextStyle,
                textDirection: TextDirection.rtl,
              ),
              Text(
                'במידה ונרשמתם אלינו תוכלו למצוא את הכרטיסים ב"הזמנות שלי"',
                style: ktextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'מאחלים לכם בילוי נעים! ולא לשכוח לדרג את הפעילות בסיומה (רק אם בא לכם כמובן 🙂 )',
                style: ktextStyleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('${e} failed order');
      EasyLoading.dismiss();
    }
  }

  Future checkDiscount(codeDiscount, eventID) async {
    try {
      final response = await ApiProvider.post(url: 'check_discount', body: {
        "code_discount": "$codeDiscount",
        "id_event": "$eventID",
      });

      print('success !!! check discount');
      print(response);
      final result = DiscountModel.fromJson(response['body']);
      discountModel = result;
      print(discountModel);
    } catch (e) {
      print('ERROR !!! check discount');
      print(e);
    }
    return discountModel;
  }

  Future groupBooking(
      {userID, email, fullName, eventTitle, eventURl, specificDate}) async {
    try {
      final response = await ApiProvider.post(
        url: 'private_group_mail',
        body: {
          "user_id": "${userID ?? ''}",
          "email": "${email ?? ''}",
          "name": "${fullName ?? ''}",
          "event_title": "${eventTitle ?? ''}",
          "date": "${bookingDate ?? ''}",
          "specific_date": "${specificDate ?? ''}",
          "beginning_time": "${beginningTime ?? ''}",
          "no_of_participants": "${numOfParticipants ?? ''}",
          "mobile_number": "${mobNumber ?? ''}",
          "more_detail": "${moreDetails ?? ''}",
          "event_url": "${eventURl ?? ''}",
        },
      );
      print('group booking chla');
      print(response);
    } catch (e) {
      print('nhi chala group booking saala');
      print(e);
    }
  }

  errorAlertMessage(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        insetPadding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        contentPadding: EdgeInsets.zero,
        title: const Center(
            child: Text(
          'תודה על הזמנתכם!',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 24),
        )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'שלחנו את הכרטיסים לאימייל שלכם.',
              style: ktextStyle,
              textDirection: TextDirection.rtl,
            ),
            Text(
              'במידה ונרשמתם אלינו תוכלו למצוא את הכרטיסים ב"הזמנות שלי"',
              style: ktextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'מאחלים לכם בילוי נעים! ולא לשכוח לדרג את הפעילות בסיומה (רק אם בא לכם כמובן 🙂 )',
              style: ktextStyleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
