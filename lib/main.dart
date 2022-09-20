// ignore_for_file: avoid_print, prefer_const_constructors, must_be_immutable

import 'package:basalon/blocs/application_bloc.dart';
import 'package:basalon/firebase_options.dart';
import 'package:basalon/screens/home_screen.dart';
import 'package:basalon/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notificationService/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

// FirebaseAnalytics analytics = FirebaseAnalytics.instance;
// web       1:121185837499:web:284bff41519b04694ae49e
// android   1:121185837499:android:b729cd1e1a1062554ae49e
// ios       1:121185837499:ios:e2d03abb1190eea04ae49e
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  var prefs = await SharedPreferences.getInstance();
  var boolKey = 'isFirstTime';
  var isFirstTime = prefs.getBool(boolKey) ?? true;
  // userIdFromLocal = prefs.getInt('loginId');
  runApp(MyApp(
    isFirstTime: isFirstTime,
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 5
    ..userInteractions = false
    ..progressColor = Colors.black
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..maskColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = false;
}

var userIdFromLocal;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late final application = ApplicationBloc();

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.isFirstTime}) : super(key: key);
  bool? isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('iw')],
        title: 'basalon',
        debugShowCheckedModeBanner: false,
        // home: HomeScreen(),
        // home: SignInScreen(),
        home: isFirstTime == true ? SplashScreen() : HomeScreen(),
        // home: UserProfile(),
        // home: GeneralScreen(),
        // home: MapSample(),
        // home: PackageScreen(),
        builder: EasyLoading.init(),
        routes: {
          HomeScreen.route: (context) => HomeScreen(),
        },
      ),
    );
  }
}
