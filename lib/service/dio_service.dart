import 'package:dio/dio.dart';

import '../models/user_model.dart';

class DioService {
  final dio = Dio();

  Future<List<User>?> fetchData() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<User> users = (response.data as List)
            .map((userData) => User.fromJson(userData))
            .toList();

        return users;
      }
    } catch (error) {
      print('Error in fetchData: $error');
      rethrow;
    }
    return null;
  }

  //TODO Add methods for postData, deleteData, etc. if needed
}
