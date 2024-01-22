import 'dart:convert';
import 'package:http/http.dart';

class NetworkMService {
  static const baseUrl = "65a77f0194c2c5762da6cce6.mockapi.io";

  static const api = "/users";

  static const headers = {
    'Content-Type': 'application/json',
  };

  static Future<String> getData(String api) async {
    Uri uri = Uri.https(baseUrl, api);
    Response response = await get(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return 'smth is wrong => ${response.statusCode}';
    }
  }

  static Future<int> postData(String api, Map<String, dynamic> json) async {
    Uri uri = Uri.https(baseUrl, api);
    Response response =
        await post(uri, headers: headers, body: jsonEncode(json));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<Map<String, dynamic>> updatePost(
      int postId, Map<String, dynamic> updatedData) async {
    Uri url = Uri.parse('$baseUrl/posts/$postId');

    try {
      Response response = await put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update post');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }

  static Future<int> deleteData(String api, String id) async {
    Uri url = Uri.https(baseUrl, "$api/$id");
    Response response = await delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Map<String, String> emptyParams() => <String, String>{};

  static Map<String, dynamic> bodyEmpty() => <String, dynamic>{};
}
