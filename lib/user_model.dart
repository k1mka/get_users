class UserModel {
  final String name;
  final String userName;
  final String email;

  UserModel({
    required this.name,
    required this.userName,
    required this.email,
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        email: json['name'],
        userName: json['username'],
        name: json['email'],
      );
}
