import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_flutter_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_flutter_app/features/auth/presentation/providers/providers.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormProvider>((
      ref,
    ) {
      final loginUserCallBack = ref.watch(authProvider.notifier).loginUser;
      return LoginFormNotifier(loginUserCallBack: loginUserCallBack);
    });

class LoginFormNotifier extends StateNotifier<LoginFormProvider> {
  final Function(String, String) loginUserCallBack;
  LoginFormNotifier({required this.loginUserCallBack})
    : super(LoginFormProvider());

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

  onFormSubmit() async {
    touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);

    await loginUserCallBack(state.email.value, state.password.value);
    state = state.copyWith(isPosting: true);
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
