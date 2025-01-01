import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:videocallsample/features/auth/data/models/user_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class HomeDataSource{
  Future<List<UserModel>> fetchHomeData();
}
class HomeDataSourceImpl implements HomeDataSource{
  FirebaseFirestore firebaseFirestore;

  HomeDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<List<UserModel>> fetchHomeData() async {
    try {
      QuerySnapshot querySnapshot =
      await firebaseFirestore.collection('users').get();

      List<UserModel> userList = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return userList;
    } catch (e, stackTrace) {
      print('Error during login: $e\n$stackTrace');
      throw ServerException('An unexpected error occurred: $e');
    }
  }

}