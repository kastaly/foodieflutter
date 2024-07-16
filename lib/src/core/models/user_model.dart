class UserModel {
  final int id;
  String name;
    String email;
  String password;

  String profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.email,
    required this.password,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',

      profilePicture: json['profile_picture'] ?? '',
    );
  }
}
