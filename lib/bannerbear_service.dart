/*
// Create this file: lib/services/bannerbear_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerBearService {
  // REPLACE THIS WITH YOUR ACTUAL API KEY
  static const String apiKey = 'bb_pr_489bc9b0e51b67a24b738f84d0840b';
  static const String baseUrl = 'https://api.bannerbear.com/v2';

  // REPLACE THIS WITH YOUR ACTUAL TEMPLATE ID
  static const String templateId = 'YOUR_TEMPLATE_ID_HERE';

  static Future<String?> createShareableImage({
    required String imageUrl,
    required String caption,
    required String username,
    String? location,
  }) async {
    try {
      print('Creating shareable image with BannerBear...');

      final response = await http.post(
        Uri.parse('$baseUrl/images'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'template': templateId,
          'modifications': [
            {
              'name': 'main_image', // Change this to match your template
              'image_url': imageUrl,
            },
            {
              'name': 'caption', // Change this to match your template
              'text': caption,
            },
            {
              'name': 'username', // Change this to match your template
              'text': '@$username',
            },
            if (location != null) {
              'name': 'location', // Change this to match your template
              'text': location,
            },
          ],
        }),
      );

      print('BannerBear response status: ${response.statusCode}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('BannerBear response: $data');
        return data['image_url'];
      }

      print('BannerBear error: ${response.body}');
      return null;
    } catch (e) {
      print('BannerBear exception: $e');
      return null;
    }
  }
}*/
// lib/services/bannerbear_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerBearService {
  // Your API Key has been added here.
  static const String _apiKey = 'bb_pr_489bc9b0e51b67a24b738f84d0840b';

  // Your Template ID has been added here.
  static const String _templateId = 'bb_pr_489bc9b0e51b67a24b738f84d0840b';

  static Future<String?> createShareableImage(String imageUrl) async {
    final url = Uri.parse('https://api.bannerbear.com/v2/images');

    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'template': _templateId,
      'modifications': [
        {
          'name': 'image_container', // Reminder: Check if this layer name is correct!
          'image_url': imageUrl,
        },
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 202) {
        final responseData = jsonDecode(response.body);
        return responseData['image_url'];
      } else {
        print('Bannerbear API Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('An exception occurred: $e');
      return null;
    }
  }
}