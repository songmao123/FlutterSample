import 'dart:convert';
import 'package:flutter_app/banner/banner.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

BannerData parseBannerData(String jsonStr) {
  var parsed = jsonDecode(jsonStr);
  var bannerData = BannerData.fromJson(parsed);
  return bannerData;
}

Future<BannerData> fetchBannerData(http.Client client) async {
  final response = await client.get('http://www.wanandroid.com/banner/json');
  print('Response: ${response.body}');
  return parseBannerData(response.body);
}
