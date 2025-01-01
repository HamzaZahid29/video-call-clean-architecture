part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}
final class SendForgerPasswordEvent extends ForgetPasswordEvent {
  final String email;

  SendForgerPasswordEvent({required this.email});
}