import 'package:http/http.dart' as http;
import 'dart:convert';

class MySQLService {
  static const String _apiUrl = 'http://127.0.0.1:3000/data';

  // Fetch all users
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);
        print(result);
        return result.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception(
            'Failed to fetch users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getUsers: $e');
      return [];
    }
  }

  // Create a user
  Future<bool> createUser(String userId, String username) async {
    try {
      final requestPayload = {
        "requests": [
          {
            "user_id": userId,
            "username": username,
          },
        ],
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestPayload),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result);
        return true;
      } else {
        throw Exception(
            'Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in createUser: $e');
      return false;
    }
  }
}
