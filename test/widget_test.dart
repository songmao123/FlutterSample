// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_app/src/banner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/json_parsing.dart';
import 'package:http/http.dart' as http;

void main() {
  test('parse banner data', () async {
    final client = http.Client();
    expect(await fetchBannerData(client), isInstanceOf<BannerData>());
  });
}
