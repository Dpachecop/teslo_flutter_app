import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_flutter_app/features/auth/presentation/providers/providers.dart';

class LoginFormProvider {
  final bool isPosting;
  final bool isValid;
  final bool ifFormPosted;
  final Email email;
  final Password password;

  LoginFormProvider({
    this.isPosting = false,
    this.isValid = false,
    this.ifFormPosted = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormProvider copyWith({
    bool? isPosting,
    bool? isValid,
    bool? ifFormPosted,
    Email? email,
    Password? password,
  }) {
    return LoginFormProvider(
      isPosting: isPosting ?? this.isPosting,
      isValid: isValid ?? this.isValid,
      ifFormPosted: ifFormPosted ?? this.ifFormPosted,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  tostring() {
    return '''
LoginFormProvider:
................................
    isPosting: $isPosting
    isValid: $isValid, 
    ifFormPosted: $ifFormPosted,
    email: $email, 
    password: $password
.................................
    ''';
  }
}

class LoginFormNotifier extends StateNotifier<LoginFormProvider> {
  LoginFormNotifier() : super(LoginFormProvider());

  void onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
    );
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.email]),
    );
  }

  onFormSubmit() {
    touchEveryField();
  }

  touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    state = state.copyWith(
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
      ifFormPosted: true,
    );
  }
}

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormProvider>(
      (ref) => LoginFormNotifier(),
    );
