import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/forget_password.dart';

part 'forget_password_event.dart';

part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPassword _forgetPassword;

  ForgetPasswordBloc({
    required ForgetPassword forgetPassword,
  })  : _forgetPassword = forgetPassword,
        super(ForgetPasswordInitial()) {
    on<SendForgerPasswordEvent>(_onSendForgerPasswordEvent);
  }

  void _onSendForgerPasswordEvent(
      SendForgerPasswordEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordLoading());
    final response =
        await _forgetPassword(ForgetPasswordParams(email: event.email));
    response.fold((l) => emit(ForgetPasswordFailure(messege: l.message)),
        (user) => emit(ForgetPasswordSuccess()));
  }
}
