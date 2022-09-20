import 'package:basalon/modal/my_orders_model.dart';
import 'package:basalon/services/api_provider/api_provider.dart';

class GetMyOrders {
  MyOrders? myOrders;
  var ticketLink;

  Future getMyOrders(userID, index) async {
    try {
      final response = await ApiProvider.post(
        url: 'get_user_orders',
        body: {
          "paged": "1",
          "user_id": "$userID",
        },
      );

      final result = MyOrders.fromJson(response['body']);
      myOrders = result;
      print(response);
      print(myOrders);
      print(' aagye orders!!!!!!!!!1');
      print(index);
      print(myOrders?.data?[index].id);
      downloadEventTicket(myOrders?.data?[index].id);
    } catch (e) {
      print('nhi aaye orders!!!!!!!!!1');
      print(e);
    }
    return myOrders;
  }

  Future downloadEventTicket(bookingID) async {
    try {
      final response = await ApiProvider.post(
        url: 'download_event_ticket',
        body: {
          "booking_id": "$bookingID",
        },
      );
      print(' aagye downloadEventTicketdownloadEventTicket!!!!!!!!!1');
      print(ticketLink = response['body']['data'][0]);
    } catch (e) {
      print(
          'nhi aaye downloadEventTicketdownloadEventTicketdownloadEventTicket!!!!!!!!!1');
      print(e);
    }
    return ticketLink;
  }

  Future userTicketEmail(bookingID) async {
    try {
      final response = await ApiProvider.post(
        url: 'user_ticket_email',
        body: {
          "booking_id": "$bookingID",
        },
      );
      print(' aagye userTicketEmail!!!!!!!!!');
      print(response);
    } catch (e) {
      print('nhi aaye userTicketEmail!!!!!!!!!1');
      print(e);
    }
  }
}
