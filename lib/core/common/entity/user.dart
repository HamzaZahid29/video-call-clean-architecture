class User{
  final String userId;
  final String email;
  final String userName;
  final String userProfilePicPath;
  final String fcmToken;

  User({required this.email,required this.userName,required this.userProfilePicPath,required this.fcmToken, required this.userId});
}