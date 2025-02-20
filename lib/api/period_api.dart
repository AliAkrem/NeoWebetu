import 'dart:convert';
import 'package:webtu_v2/api/exceptions.dart';
import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/utils/http/methods.dart';
import 'package:webtu_v2/models/period.dart';

// Custom exceptions for better error handling

Future<List<Period>> getCurrentPeriod(int levelId) async {
  // Validate input
  if (levelId <= 0) {
    throw InvalidInputException('Level ID must be a positive integer');
  }

  try {
    // Make API call
    final response = await get(PERIOD_URL(levelId), true).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw NetworkException(
          message: 'Request timed out',
          statusCode: -1,
        );
      },
    );

    // Check response status
    if (response.statusCode != 200) {
      throw NetworkException(
        message: 'Failed to load periods',
        statusCode: response.statusCode,
      );
    }

    // Parse JSON response
    List<dynamic> formattedData;
    try {
      formattedData = json.decode(response.body);
      if (formattedData.isEmpty) {
        // Return empty list instead of throwing if no periods found
        return [];
      }
    } catch (e) {
      throw DataParsingException('Failed to decode JSON response', e);
    }

    // Process periods
    List<Period> periods = [];
    List<String> parsingErrors = []; // Collect all parsing errors

    for (var element in formattedData) {
      try {
        // Handle string encoding
        if (element is String) {
          element = utf8.decode(latin1.encode(element));
        }

        // Validate element structure
        if (element == null) {
          parsingErrors.add('Null period data encountered');
          continue;
        }

        // Create Period object
        final period = Period.fromJson(element);

        periods.add(period);
      } catch (e) {
        parsingErrors.add('Error parsing period: $e');
        continue;
      }
    }

    // Log parsing errors if any occurred
    if (parsingErrors.isNotEmpty) {
      print('Warning: Some periods failed to parse:');
      parsingErrors.forEach((error) => print('- $error'));
    }

    // Return successfully parsed periods
    return periods;
  } on NetworkException {
    rethrow; // Let caller handle network errors
  } on DataParsingException {
    rethrow; // Let caller handle parsing errors
  } catch (e) {
    throw Exception('Unexpected error while fetching periods: $e');
  }
}
