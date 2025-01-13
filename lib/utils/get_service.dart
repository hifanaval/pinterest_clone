import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_utils.dart';

class GetServiceUtils {
  static Future<String> fetchData(String getUrl, BuildContext context) async {
    try {
      final hasNetwork = await AppUtils.hasInternet();
      if (!hasNetwork) {
        if (context.mounted) {
          AppUtils.showToast(context, "No internet connection",
              "Connect your phone to wifi or mobile data", false);
        }
        throw Exception('No internet connection');
      }

      debugPrint('Fetching data from: $getUrl');
      final url = Uri.parse(getUrl);

      final headers = {
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          log('$url: ${response.body}');
        }
        return response.body;
      }

      // Handle error cases
      if (context.mounted) {
        switch (response.statusCode) {
          case 500:
            AppUtils.showToast(
                context,
                "Server Error",
                'Internal server error occurred. Please try again later.',
                false);
            break;
          default:
            AppUtils.showToast(context, "Error",
                'Failed to load data. Please try again.', false);
        }
      }

      debugPrint('$url status code: ${response.statusCode}');
      throw Exception('Failed to get data: ${response.statusCode}');
    } catch (e) {
      debugPrint('Error fetching data: $e');
      // if (context.mounted) {
      //   AppUtils.showToast(
      //       context, "Error", 'An error occurred while fetching data', false);
      // }
      rethrow;
    }
  }
}
