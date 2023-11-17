import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<String> fetchAndParseJson() async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyyMMdd').format(now);
  //String formattedDate = '20231106';
  String url =
      'https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=71802949356947df81a77f2b35bee004&Type=json&pIndex=1&pSize=1&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010057&MLSV_YMD=';
  final response = await http.get(Uri.parse('$url$formattedDate'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse.containsKey('mealServiceDietInfo')) {
      // 급식 데이터가 있는 경우
      var mealData = jsonResponse['mealServiceDietInfo'][1]['row'][0];
      String lunchMenu = mealData['DDISH_NM'];
      var result = lunchMenu.replaceAll('<br/>', '\n');
      return result;
    } else if (jsonResponse.containsKey('RESULT') &&
        jsonResponse['RESULT']['CODE'] == 'INFO-200') {
      // 급식 데이터가 없는 경우
      return '급식 데이터가 없습니다.';
    }
  } else {
    throw Exception('Failed to load meal data');
  }
  return 'Unknown error';
}

Future<String> fetchAndParseJsonTomorrow() async {
  DateTime now = DateTime.now();
  DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
  String formattedDate = DateFormat('yyyyMMdd').format(tomorrow);
  //String formattedDate = '20231106';
  String url =
      'https://open.neis.go.kr/hub/mealServiceDietInfo?KEY=71802949356947df81a77f2b35bee004&Type=json&pIndex=1&pSize=1&ATPT_OFCDC_SC_CODE=B10&SD_SCHUL_CODE=7010057&MLSV_YMD=';
  final response = await http.get(Uri.parse('$url$formattedDate'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse.containsKey('mealServiceDietInfo')) {
      // 급식 데이터가 있는 경우
      var mealData = jsonResponse['mealServiceDietInfo'][1]['row'][0];
      String lunchMenu = mealData['DDISH_NM'];
      var result = lunchMenu.replaceAll('<br/>', '\n');
      return result;
    } else if (jsonResponse.containsKey('RESULT') &&
        jsonResponse['RESULT']['CODE'] == 'INFO-200') {
      // 급식 데이터가 없는 경우
      return '급식이 없는 날이거나 데이터가 없습니다. 기다려주세요.';
    }
  } else {
    throw Exception('Failed to load meal data');
  }
  return 'Unknown error';
}