import 'package:bloc/bloc.dart';
import 'package:stock_app/repositories/social_repository/user_hive_repository.dart';
import 'package:stock_app/screen/login/bloc/login_event.dart';
import 'package:stock_app/screen/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required UserHiveRepository userRepository,
  }) : _userRepository = userRepository,
        super(const LoginState()) {
    on<LoginUserNameChange>(_onUserNameChange);
    on<LoginPasswordChange>(_onPasswordChange);
    on<LoginChangeStatus>(_onChangeStatus);
    on<LoginSubmit>(_onSubmit);
  }

  final UserHiveRepository _userRepository;

  void _onUserNameChange(
      LoginUserNameChange event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(
      username: () => event.username,
    ));
  }

  void _onPasswordChange(
      LoginPasswordChange event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(
      password: () => event.password,
    ));
  }

  void _onChangeStatus(
      LoginChangeStatus event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(
      loginStatus: () => LoginStatus.initial,
    ));
  }

  Future<void> _onSubmit (
      LoginSubmit event,
      Emitter<LoginState> emit,
      ) async{
    emit(state.copyWith(
      loginStatus: () => LoginStatus.loading,
    ));
    bool login = _userRepository.login(
      state.username,
      state.username,
      state.password,
    );
    if (login) {
      emit(state.copyWith(
        loginStatus: () => LoginStatus.success,
      ));
    } else {
      emit(state.copyWith(
        loginStatus: () => LoginStatus.failure,
      ));
    }
  }
}