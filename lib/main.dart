import 'package:flutter/material.dart';
import 'package:garakmealinfo/onboarding_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: initializeDateFormatting('ko_KR', null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            DateTime now = DateTime.now();
            DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
            String nowDate = DateFormat('yyyy-MM-dd (E)', 'ko_KR').format(now);
            String tomorrowDate = DateFormat('yyyy-MM-dd (E)', 'ko_KR').format(tomorrow);

            return OnboardingPage(
              pages: [
                OnboardingPageModel(
                  title: '$nowDate 오늘 급식 메뉴^^',
                  image: 'assets/images/image0.png',
                  bgColor: Colors.indigo,
                ),
                OnboardingPageModel(
                  title: '$tomorrowDate 내일 메뉴^^ 기대되죠?',
                  image: 'assets/images/image1.png',
                  bgColor: const Color(0xff1eb090),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
