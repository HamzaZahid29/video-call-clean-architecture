import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../notification_service.dart';
import '../models/user_model.dart';

abstract interface class AuthFirebaseDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUser();

  Future<void> logoutUser();
}

class AuthFirebaseDataSourceImpl extends AuthFirebaseDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseMessaging firebaseMessaging;
  final NotificationService notificationService;



  AuthFirebaseDataSourceImpl(this.firebaseAuth, this.firebaseMessaging, this.notificationService);

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return await getCurrentUser();
    } on FirebaseAuthException catch (authError) {
      print('FirebaseAuthException: ${authError.message}');
      throw ServerException('Authentication failed: ${authError.message}');
    } catch (e, stackTrace) {
      print('Error during login: $e\n$stackTrace');
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (firebaseAuth.currentUser != null) {
          var user = firebaseAuth.currentUser;
          final userId = user?.uid;

          String? fcmToken = await notificationService.getToken();

          Map<String, dynamic> userData = {
            'userId': userId,
            'name': name,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
            'profilePictureUrl': null,
            'fcmToken': fcmToken,
          };

          try {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .set(userData)
                .catchError((e) {
              print('Error occurred while saving user data: $e');
              throw ServerException('Error saving user data: $e');
            });
          } catch (e) {
            print('Error in Firestore saving: $e');
            throw ServerException('Error in Firestore saving: $e');
          }
        }
      });

      if (firebaseAuth.currentUser == null) {
        throw ServerException('User is null');
      }

      return await getCurrentUser();
    } catch (e) {
      print('Error during signup: $e');
      throw ServerException(e.toString());
    }
  }


  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        throw ServerException('No user is currently signed in');
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        throw ServerException('User document not found in Firestore');
      }

      final userData = userDoc.data();
      if (userData == null) {
        throw ServerException('User document is empty');
      }

      return UserModel(
        userId: userData['userId'] as String,
        email: userData['email'] as String,
        userName: userData['name'] as String,
        userProfilePicPath: userData['profilePictureUrl'] as String?,
        userRole: userData['role'] as String,
      );
    } on FirebaseException catch (firestoreError) {
      print('FirebaseException: ${firestoreError.message}');
      throw ServerException('Firestore error: ${firestoreError.message}');
    } catch (e, stackTrace) {
      print('Error fetching current user: $e\n$stackTrace');
      throw ServerException(
          'An unexpected error occurred while fetching user: $e');
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseException catch (firestoreError) {
      print('FirebaseException: ${firestoreError.message}');
      throw ServerException('Firestore error: ${firestoreError.message}');
    } catch (e, stackTrace) {
      print('Error fetching current user: $e\n$stackTrace');
      throw ServerException(
          'An unexpected error occurred while fetching user: $e');
    }
  }
}
