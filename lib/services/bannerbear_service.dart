// lib/services/bannerbear_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerBearService {
  // IMPORTANT: Replace with your actual Bannerbear Project API Key
  static const String _apiKey = 'YOUR_BANNERBEAR_API_KEY';

  // IMPORTANT: Replace with your actual Bannerbear Template ID
  static const String _templateId = 'YOUR_TEMPLATE_ID';

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
          'name': 'image_container', // Replace with the layer name of the image in your Bannerbear template
          'image_url': imageUrl,
        },
        // Add other modifications here if your template needs them
        // {
        //   'name': 'text_container',
        //   'text': 'Some text for the banner'
        // }
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 202) {
        final responseData = jsonDecode(response.body);
        // The image_url is the final generated image from Bannerbear
        return responseData['image_url'];
      } else {
        // If the API call fails, print the error
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