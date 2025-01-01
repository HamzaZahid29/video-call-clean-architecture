import '../../../../core/common/entity/user.dart';

class UserModel extends User {
  UserModel({
    required String userId,
    required String email,
    required String userName,
    String? userProfilePicPath,
    required String fcmToken,
  }) : super(
    userId: userId,
    email: email,
    userName: userName,
    userProfilePicPath: userProfilePicPath ?? '',
    fcmToken: fcmToken,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      userName: json['name'] as String,
      userProfilePicPath: json['profilePictureUrl'] as String?,
      fcmToken: json['fcmToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': userName,
      'profilePictureUrl': userProfilePicPath,
      'fcmToken': fcmToken,
    };
  }
}
