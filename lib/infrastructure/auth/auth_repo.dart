import 'package:cloud_firestore/cloud_firestore.dart' hide Source;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:moneybook/domain/app/source.dart';
import 'package:moneybook/domain/auth/signup_body.dart';
import 'package:moneybook/domain/auth/login_body.dart';
import 'package:moneybook/domain/app/user_profile.dart';
import 'package:fpdart/src/either.dart';
import 'package:clean_api/src/api_failure.dart';
import 'package:moneybook/presentation/auth/i_auth_repo.dart';

class AuthRepo extends IAuthRepo {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  @override
  TaskEither<CleanFailure, UserProfile> login(LogInBody body) =>
      TaskEither.tryCatch(
        () async {
          final loginResponse = await auth.signInWithEmailAndPassword(
              email: body.email, password: body.password);

          if (loginResponse.user != null) {
            final data = await db
                .collection('User')
                .doc(loginResponse.user!.uid)
                .get()
                .then((value) => value.data());

            if (data != null) {
              final profile = UserProfile.fromMap(data);
              return profile;
            } else {
              throw 'Profile does not exist';
            }
          } else {
            throw 'Log in was unsuccessful';
          }
        },
        (error, _) => CleanFailure(
          tag: 'log in',
          error: error.toString(),
        ),
      );

  @override
  TaskEither<CleanFailure, UserProfile> signup(SignUpBody body) =>
      TaskEither.tryCatch(
        () async {
          final loginResponse = await auth.createUserWithEmailAndPassword(
              email: body.email, password: body.password);

          if (loginResponse.user != null) {
            final profile = UserProfile(
              name: body.name,
              id: loginResponse.user!.uid,
              email: body.email,
              sources: [
                Source(
                  name: 'Cash',
                  createdAt: DateTime.now(),
                ),
              ],
            );

            await db
                .collection('User')
                .doc(loginResponse.user!.uid)
                .set(profile.toMap());

            return profile;
          } else {
            throw 'Sign in was unsuccessful';
          }
        },
        (error, _) => CleanFailure(
          tag: 'Sign in',
          error: error.toString(),
        ),
      );

  @override
  TaskEither<CleanFailure, UserProfile> checkAuth() => TaskEither.tryCatch(
        () async {
          final user = auth.currentUser;

          if (user != null) {
            final data = await db
                .collection('User')
                .doc(user.uid)
                .get()
                .then((value) => value.data());

            if (data != null) {
              final profile = UserProfile.fromMap(data);
              return profile;
            } else {
              throw 'Profile does not exist';
            }
          } else {
            throw 'You are not logged in';
          }
        },
        (error, _) => CleanFailure(
          tag: 'log in',
          error: error.toString(),
        ),
      );

  @override
  Future<void> logout() async {
    // TODO: implement logout
    await auth.signOut();
  }
}
