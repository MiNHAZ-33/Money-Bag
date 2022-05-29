import 'package:clean_api/clean_api.dart';
import 'package:moneybook/domain/app/user_profile.dart';
import 'package:moneybook/domain/auth/login_body.dart';
import 'package:moneybook/domain/auth/signup_body.dart';

abstract class IAuthRepo {
  TaskEither<CleanFailure, UserProfile> login(LogInBody body);
  TaskEither<CleanFailure, UserProfile> signup(SignUpBody body);
  TaskEither<CleanFailure, UserProfile> checkAuth();
  Future<void> logout();
}
