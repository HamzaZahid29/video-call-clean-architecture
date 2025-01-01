import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';

abstract class ForgetPasswordDataSource {
  Future<void> sendResetPasswordLink({
    required String email,
  });
}

class ForgetPasswordDataSourceImpl implements ForgetPasswordDataSource {
  final FirebaseAuth firebaseAuth;

  ForgetPasswordDataSourceImpl(this.firebaseAuth);

  @override
  Future<void> sendResetPasswordLink({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (authError) {
      throw ServerException('Authentication failed: ${authError.message}');
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }
}
