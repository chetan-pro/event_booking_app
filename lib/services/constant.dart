// const String url = 'http://165.22.222.20/demo/SYR/';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String url = 'https://basalon.co.il/wp-json/wp/v2/';
String? api;
const double kDesignWidth = 360;
const double kDesignHeight = 760;
const String auth_key = 'XkCRn9Y4PPmspuqYKolqbyhcDFhID7kl';
const String client_service = 'basalon-client-t1T83YHm60J8yNG5';

//TextStyle
const ktextStyle = TextStyle(fontSize: 16, color: Colors.black);
const ktextStyleSmall = TextStyle(fontSize: 12, color: Colors.black);
const ktextStyleBold =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);
const ktextStyleBoldMedium =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);
const ktextStyleBoldSmall =
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black);
const ktextStyleLarge = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

//WHITE
const ktextStyleSmallWhite = TextStyle(fontSize: 12, color: Colors.white);

const ktextStyleWhite = TextStyle(
  fontSize: 16,
  color: Color.fromRGBO(241, 241, 241, 1),
);
const ktextStyleWhiteBold = TextStyle(
  fontSize: 16,
  color: Color.fromRGBO(241, 241, 241, 1),
  fontWeight: FontWeight.bold,
);

const ktextStyleWhiteLarge = TextStyle(
  fontSize: 20,
  color: Color.fromRGBO(241, 241, 241, 1),
  fontWeight: FontWeight.bold,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
    )
  ],
);

const kgoogleMapKey = "AIzaSyBHVBZkraM4LCgOhi85c4mDYHl2C-e4fnQ";

const ktimeList = [
  '00.00',
  '00.15',
  '00.30',
  '00.45',
  '01:00',
  '01:15',
  '01:30',
  '01:45',
  '02:00',
  '02:15',
  '02:30',
  '02:45',
  '03:00',
  '03:15',
  '03:30',
  '03:45',
  '04:00',
  '04:15',
  '04:30',
  '04:45',
  '05:00',
  '05:15',
  '05:30',
  '05:45',
  '06:00',
  '06:15',
  '06:30',
  '06:45',
  '07:00',
  '07:15',
  '07:30',
  '07:45',
  '08:00',
  '08:15',
  '08:30',
  '08:45',
  '09:00',
  '09:15',
  '09:30',
  '09:45',
  '10:00',
  '10:15',
  '10:30',
  '10:45',
  '11:00',
  '11:15',
  '11:30',
  '11:45',
  '12:00',
  '12:15',
  '12:30',
  '12:45',
  '13:00',
  '13:15',
  '13:30',
  '13:45',
  '14:00',
  '14:15',
  '14:30',
  '14:45',
  '15:00',
  '15:15',
  '15:30',
  '15:45',
  '16:00',
  '16:15',
  '16:30',
  '16:45',
  '17:00',
  '17:15',
  '17:30',
  '17:45',
  '18:00',
  '18:15',
  '18:30',
  '18:45',
  '19:00',
  '19:15',
  '19:30',
  '19:45',
  '20:00',
  '20:15',
  '20:30',
  '20:45',
  '21:00',
  '21:15',
  '21:30',
  '21:45',
  '22:00',
  '22:15',
  '22:30',
  '22:45',
  '23:00',
  '23:15',
  '23:30',
  '23:45',
];

const kDateTimeList = [
  'כל תאריך',
  'שבוע הבא',
  'בעוד שבועיים',
  'חודש הבא',
  'תאריך ספציפי',
];
const kbeginningTime = [
  // 'שעת התחלה',
  'בוקר',
  'אחר הצהריים',
  'ערב',
];
const kparticipants = [
  '1-4',
  '5-20',
  '21-50',
  '51-200',
  '201-500',
];

const kdateList = [
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37'
];

const kmonthList = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12'
];

const kCategoryList = [
  'מפגש חברתי',
  'הרצאה',
  'הופעה',
  'סדנת יצירה',
  'סדנת גוף/נפש',
  'סדנת בישול',
  'חיפוש חופשי',
  'פעילות לילדים',
  'אירוח קולינרי',
];

const kLogoImage = 'assets/4.png';
