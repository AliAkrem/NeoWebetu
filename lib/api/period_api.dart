import 'dart:convert';

import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/http/requests.dart';
import 'package:webtu_v2/models/period.dart';

Future<List<Period>> getPeriod(int levelId) async {
  try {
    final res = await get(PERIOD_URL(levelId), true);

    if (res.statusCode != 200) {
      throw Exception('Failed to load periods: ${res.statusCode}');
    }

    final formattedData = json.decode(res.body);
    List<Period> periods = [];

    for (var element in formattedData) {
      try {
        if (element is String) {
          element = utf8.decode(latin1.encode(element));
        }
        periods.add(Period.fromJson(element));
      } catch (e) {
        print('Error parsing period: $e');
        continue;
      }
    }

    return periods;
  } catch (e) {
    throw Exception('Failed to fetch periods: $e');
  }
}
