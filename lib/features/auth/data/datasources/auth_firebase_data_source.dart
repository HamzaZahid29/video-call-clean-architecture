import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/static_database_maps.dart';
import '../models/user_model.dart';

abstract interface class AuthFirebaseDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
    required String role,
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

  AuthFirebaseDataSourceImpl(this.firebaseAuth);

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
  Future<UserModel> signUpWithEmailPassword(
      {required String email,
      required String password,
      required String name,
      required String role}) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (firebaseAuth.currentUser != null) {
          var user = firebaseAuth.currentUser;
          final userId = user?.uid;
          Map<String, dynamic> userData = {
            'userId': userId,
            'name': name,
            'role': role,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
            'profilePictureUrl': null,
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
            await FirebaseFirestore.instance
                .collection('user-notifications')
                .doc(user.uid)
                .set({
              'userId': user.uid,
              'notifications': [],
            }).catchError((e) {
              throw ServerException('Error saving user data: $e');
            });
            if (role == 'Caregiver') {
              await FirebaseFirestore.instance
                  .collection('caregiver-documents')
                  .doc(user!.uid)
                  .set({
                'documents': StaticDatabaseMaps.caregiverDefaultDatabaseMap,
              }).catchError((e) {
                print('Error occurred while saving user data: $e');
                throw ServerException('Error saving user data: $e');
              });

              await FirebaseFirestore.instance
                  .collection('caregiver-reports')
                  .doc(user.uid)
                  .set({
                'caregiverId': user.uid,
                'arrayOfAssignedTasks': [],
                'isAvailable': true,
                'arrayOfCompletedTasks': [],
              }).catchError((e) {
                print('Error occurred while saving user data: $e');
                throw ServerException('Error saving user data: $e');
              });
            } else if (role == 'Caretaker') {
              await FirebaseFirestore.instance
                  .collection('caretaker-documents')
                  .doc(user!.uid)
                  .set({
                'documents': StaticDatabaseMaps.caretakerDefaultDatabaseMap,
              }).catchError((e) {
                print('Error occurred while saving user data: $e');
                throw ServerException('Error saving user data: $e');
              });
            }
          } catch (e) {
            print('Error while adding user to Firestore: ${e.toString()}');
            throw ServerException(
                'Error while adding user to Firestore: ${e.toString()}');
          }
        } else {
          throw ServerException('User is null');
        }
      });
      if (firebaseAuth.currentUser == null) {
        throw ServerException('User is null');
      }
      return await getCurrentUser();
    } catch (e) {
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
