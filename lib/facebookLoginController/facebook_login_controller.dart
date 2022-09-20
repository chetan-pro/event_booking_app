import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInController extends ChangeNotifier {
  Map? userData;

  login() async {
    try {
      var result = await FacebookAuth.i.login(
        permissions: ["public_profile", "email"],
      );
      if (result.status == LoginStatus.success) {
        final requestData = FacebookAuth.i.getUserData(
          fields: "email ,name",
        );
        userData = requestData as Map?;
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint("$e");
      debugPrint("facrebok erroe");
    }
  }

  logout() async {
    await FacebookAuth.i.logOut();
    userData = null;
    notifyListeners();
  }
}
