part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  const LoginState({
    required this.status,
    required this.email,
    required this.password,
    required this.isValidForm,
  });

  const LoginState.initial()
      : this(
          status: LoginStatus.initial,
          email: '',
          password: '',
          isValidForm: false,
        );

  final LoginStatus status;
  final String email;
  final String password;
  final bool isValidForm;

  LoginState copyWith({
    LoginStatus? status,
    String? email,
    String? password,
    bool? isValidForm,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValidForm: isValidForm ?? this.isValidForm,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        password,
        isValidForm,
      ];
}
