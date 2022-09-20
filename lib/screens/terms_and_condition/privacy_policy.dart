

import 'package:basalon/services/constant.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Container(
              //   height: 100,
              //   child: Stack(
              //     children: [
              //       Image.asset(
              //         'assets/top-image.jpg',
              //         width: 300,
              //         fit: BoxFit.fill,
              //       ),
              //     ],
              //   ),
              // )
              SizedBox(
                height: 50,
              ),
              Text(
                'מדיניות הפרטיות',
                style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
              Text(
                'פרטיות וסודיות',
                style: ktextStyleBoldMedium,
                textAlign: TextAlign.end,
              ),


              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('''
1.1 משתמש הקצה ו/או בית העסק מכיר בזאת שכל הדיונים, דירוגים, הערות, שירות לוח המודעות, חדרי הצ’ט, תמונת הפרופיל, שם המשתמש והפעילות באתר ו/או כל תשתיות הודעות ותקשורות באתר (“קהילות”) הם פומביים ואינן תקשורות פרטיות, ולכן צדדים שלישים רשאים לקרוא את התקשורות של משתמש הקצה ו/או בית העסק וכן לצפות בתמונת הפרופיל, שם המשתמש והפעילות שביצע באתר מבלי ידיעתו. קבוצת basalon אינה שולטת או נותנת חסות לתוכן, להודעות או למידע הנמצא בכל קהילה ולכן קבוצת basalon מסתלקת באופן מפורש מכל חבות הנוגעת לקהילות ואינה אחראית לשום תוצאה הנובעת מהשתתפות משתמש הקצה ו/או בית העסק בקהילות. כל מידע שמשתמש קצה ו/או בית העסק מפרסם ו/או שנוצר על ידי השימוש באתר, בין אם בחדרי הצ’ט, בחדרי הדיונים, על לוחות המודעות או בכל דרך אחרת, אינו מידע שחלה עליו סודיות כלשהי. על ידי פרסום הערות, הודעות ו/או מידע אחר באתר, משתמש הקצה ו/או בית העסק מקנה לקבוצת basalon את זכות השימוש באותן הערות, הודעות ו/או מידע אחר לצורך קידום מכירות, פרסום, חקר שוק וכן לכל מטרה חוקית אחרת מבלי הגבלה של טריטוריה, זמן או כל הגבלה אחרת.

1.2 כל פרטיו האישיים של משתמש הקצה ו/או בית העסק (שם, תמונת הפרופיל, דואר אלקטרוני וכדומה) שמסר משתמש הקצה ו/או בית העסק במסגרת רישומו לאתר ושימושו באתר, ומידע שייאסף אודות דפוסי השימוש של משתמשי הקצה ו/או בתי העסק, יישמרו במאגרי המידע של קבוצת basalon.

1.3 basalon תהא רשאית להשתמש בפרטיו האישיים של משתמש הקצה ו/או בית העסק ובמידע שתאסוף אודות דפוסי השימוש שלהם באתר, בכפוף לכל דין, לרבות לצורך:

1.3.1 העברת המידע לבית העסק לצורך הפעילות ו/או השירות נשוא רכישת הכרטיסים בלבד. מובהר בזאת כי בית העסק אינו רשאי לעשות כל שימוש אחר במידע שיועבר אליו מבלי לקבל את הסכמתו המפורשת של משתמש הקצה אשר רכש את הכרטיס;

1.3.2 שיפור ותחזוקת השירותים, המידע והתכנים המוצעים באתר;

1.3.3 לשנות ו/או לבטל שירותים ותכנים הקיימים באתר;

1.3.4 מתן הודעות בקשר עם האתר והשימוש בו;

1.3.5 ניתוח מידע סטטיסטי והצגתו ו/או מסירתו לצדדים שלישיים, ובלבד שהמידע כאמור יהיה אנונימי.

1.4 basalon לא תעשה כל שימוש בפרטים של אמצעי התשלום של משתמש הקצה אלא לביצוע תשלום בגין עסקה אותה ביקש משתמש הקצה לערוך, ופרטים אלו לא יועברו לאף גורם אחר זולת לצורך זה.

1.5 פרטי כרטיס האשראי אינם נשמרים במאגרי המידע של basalon.

1.6 basalon לא תמכור ו/או תשכיר ו/או תעביר את פרטיו האישיים של משתמש הקצה ו/או בית העסק, כפי שנמסרו לה על ידם, כולם או חלקם, לצד שלישי כלשהו, למעט לגוף מסונף אליה (חברת בת, חברת אם, חברה אחות, חברה בשליטה משותפת עם basalon וכו’). אין באמור כדי למנוע מ-basalon להעביר מידע סטטיסטי שאינו כולל פרטים מזהים לצדדים שלישיים.

1.7 למרות האמור לעיל, basalon תהא רשאית להעביר פרטיו האישיים של משתמש הקצה ו/או בית העסק לצד שלישי במקרים הבאים:

1.7.1 כאשר התקבלה הסכמת משתמש הקצה ו/או בית העסק;

1.7.2 משתמש הקצה ו/או בית העסק ביצע מעשה או מחדל הפוגעים ו/או העלולים, לפי שיקול דעתה הבלעדי של basalon, לפגוע ב- basalon ו/או בצדדים שלישיים כלשהם; משתמש הקצה ו/או בית העסק עשה שימוש בשירותי basalon באופן אשר לפי שיקול דעתה הבלעדי של basalon עשוי להיות מעשה בלתי חוקי; אם התקבל בידי basalon צו שיפוטי המורה לה למסור את פרטי משתמש הקצה ו/או בית העסק לצד שלישי וכן בכל מחלוקת או הליכים משפטיים;

1.7.3 במקרה שבו basalon תעביר בכל צורה שהיא את פעילות האתר לתאגיד כלשהו וכן במקרה שתתמזג עם גוף אחר או תמזג את פעילות האתר עם פעילותו של צד שלישי, ובלבד שתאגיד זה יקבל על עצמו כלפי משתמשי הקצה ובתי העסק את הוראות תנאי השימוש.

1.8 פעילות האתר מבוצעת בסביבה מקוונת. לפיכך אין באפשרותה של basalon להבטיח חסינות מוחלטת מפני חדירות למחשביה או חשיפת המידע האגור בידי מבצעי פעולות בלתי חוקיות. אם יעלה בידי צד שלישי לחדור למידע אשר שמור בידי basalon ו/או להשתמש בו לרעה, לא תהיה למשתמש הקצה ו/או לבית העסק כל טענה, תביעה או דרישה כלפי basalon.

1.9 בקרות מקרים שאינם בשליטתה של basalon ו/או הנובעים מכח עליון, basalon לא תהא אחראית לכל נזק מכל סוג שהוא, עקיף או ישיר, שייגרם לך ו/או למי מטעמך עם מידע זה יאבד או אם יעשה בו שימוש לא מורשה.

1.10 basalon תהא רשאית לעשות שימוש ב – “עוגיות” (“cookies”) על מנת לספק למשתמש הקצה ו/או לבית העסק שירות מהיר ויעיל ולחסוך ממשתמש הקצה ו/או בית העסק את הצורך להזין את פרטיו האישיים בכל כניסה לאתר.

1.11 משתמש הקצה יהיה ראשי לבקש שהמידע שנאסף אודותיו ימחק ממאגרי המידע של קבוצת Basalon, את הבקשה יש לשלוח למייל info@basalon.co.il
                      ''',style: ktextStyle,),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
