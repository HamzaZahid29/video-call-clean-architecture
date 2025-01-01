part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}
final class ForgetPasswordLoading extends ForgetPasswordState {}
final class ForgetPasswordSuccess extends ForgetPasswordState {}
final class ForgetPasswordFailure extends ForgetPasswordState {

  final String messege;

  ForgetPasswordFailure({required this.messege});
}
