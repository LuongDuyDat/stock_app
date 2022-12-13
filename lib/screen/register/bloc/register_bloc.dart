import 'package:bloc/bloc.dart';
import 'package:stock_app/repositories/social_repository/user_hive_repository.dart';
import 'package:stock_app/screen/login/bloc/login_event.dart';
import 'package:stock_app/screen/login/bloc/login_state.dart';
import 'package:stock_app/screen/register/bloc/register_event.dart';
import 'package:stock_app/screen/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required UserHiveRepository userRepository,
  }) : _userRepository = userRepository,
        super(const RegisterState()) {
    on<RegisterUserNameChange>(_onUserNameChange);
    on<RegisterEmailChange>(_onEmailChange);
    on<RegisterNameChange>(_onNameChange);
    on<RegisterPasswordChange>(_onPasswordChange);
    on<RegisterSubmit>(_onSubmit);
  }

  final UserHiveRepository _userRepository;

  void _onEmailChange(
      RegisterEmailChange event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(
      email: () => event.email,
    ));
  }

  void _onNameChange(
      RegisterNameChange event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(
      name: () => event.name,
    ));
  }

  void _onUserNameChange(
      RegisterUserNameChange event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(
      username: () => event.username,
    ));
  }

  void _onPasswordChange(
      RegisterPasswordChange event,
      Emitter<RegisterState> emit,
      ) {
    emit(state.copyWith(
      password: () => event.password,
    ));
  }

  Future<void> _onSubmit (
      RegisterSubmit event,
      Emitter<RegisterState> emit,
      ) async{
    emit(state.copyWith(
      registerStatus: () => RegisterStatus.loading,
    ));
    bool register = _userRepository.register(
      state.name,
      state.username,
      state.email,
      state.password,
    );
    if (register) {
      emit(state.copyWith(
        registerStatus: () => RegisterStatus.success,
      ));
    } else {
      emit(state.copyWith(
        registerStatus: () => RegisterStatus.failure,
      ));
    }
  }
}