import 'dart:convert';

import 'package:get_users/user_model.dart';
import 'package:http/http.dart';

abstract class GetUsersService {
  Future<UserModel> fetchUsers();
}

class GetUsersServiceImpl extends GetUsersService {
  @override
  Future<UserModel> fetchUsers() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await get(url);
    return UserModel.fromJson(json.decode(response.body)[0]);
  }
}
