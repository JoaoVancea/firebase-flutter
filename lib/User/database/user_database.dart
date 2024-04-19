import 'package:login_cadastro/User/model/user_model.dart';

class UserDataBase {
  static List<UserModel> users = [];

  static addUser(UserModel user) async {
    users.add(user);
  }

}
