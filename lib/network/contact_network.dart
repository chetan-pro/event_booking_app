import 'package:basalon/modal/contact_data.dart';
import 'package:basalon/services/api_provider/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ContactNetWork {
  Contact? contact;
  Dio dio = Dio();

  Future getContact() async {
    try {
      final response = await ApiProvider.get('contat_page/');
      final result = Contact.fromJson(response['body']);
      contact = result;
      print('chalgyi contact yeahhh');
      print(response);
      print(contact?.data);
    } catch (e) {
      print('contac nhi chli re baba');
      print(e);
    }
  }

  Future postContact(name, email, message, context) async {
    try {
      Response response;
      response = await dio.post(
        'https://basalon.co.il/wp-json/contact-form-7/v1/contact-forms/304/feedback',
        data: FormData.fromMap(
          {
            "your-name": name,
            "your-email": email,
            "your-message": message,
          },
        ),
      );

      print('chalgyi postContact yeahhh');
      print(response.data['message']);
      print(response.data);
      if (response.data['status'] == 'validation_failed') {
        print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
        errorAlertMessage('errorMessage', context);
      }
    } catch (e) {
      print('postContact nhi chli re baba');
      print(e);
    }
  }

  void errorAlertMessage(String errorMessage, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Check Your Email!')),
        // content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
