import 'dart:convert';

class Users
{
  static String id = " ";
  static String uid = " ";
  static String employeeId = " ";
  static double lat = 0;
  static double long = 0;
  static String firstName = "";
  static String lastName = "";
  static String address = "";
  static String birthDate = "";
  static String profilePicLink = "";
  static bool canEdit = true;
  String user;
  String password;
  List modelData;

  Users({
    required this.user,
    required this.password,
    required this.modelData,
  });

  static Users fromMap(Map<String, dynamic> user) {
    return new Users(
      user: user['user'],
      password: user['password'],
      modelData: jsonDecode(user['model_data']),
    );
  }

  toMap() {
    return {
      'user': user,
      'password': password,
      'model_data': jsonEncode(modelData),
    };
  }
}