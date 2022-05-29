import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybook/application/auth/auth_state.dart';
import 'package:moneybook/domain/auth/login_body.dart';
import 'package:moneybook/domain/auth/signup_body.dart';
import 'package:moneybook/infrastructure/auth/auth_repo.dart';
import 'package:moneybook/presentation/auth/i_auth_repo.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthRepo());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepo authRepo;
  AuthNotifier(this.authRepo) : super(AuthState.init());

  login(LogInBody body) async {
    state = AuthState.init().copyWith(loading: true);
    final response = await authRepo.login(body).run();

    state = response
        .fold((l) => state.copyWith(failure: l),
            (r) => state.copyWith(profile: r))
        .copyWith(loading: false);
  }

  signUp(SignUpBody body) async {
    state = AuthState.init().copyWith(loading: true);
    final response = await authRepo.signup(body).run();

    state = response
        .fold((l) => state.copyWith(failure: l),
            (r) => state.copyWith(profile: r))
        .copyWith(loading: false);
  }

  checkAuth() async {
    state = state.copyWith(loading: true);
    final response = await authRepo.checkAuth().run();

    state = response
        .fold((l) => state.copyWith(failure: l),
            (r) => state.copyWith(profile: r))
        .copyWith(loading: false);
  }

  logout() async {
    await authRepo.logout();
    state = AuthState.init();
  }
}
