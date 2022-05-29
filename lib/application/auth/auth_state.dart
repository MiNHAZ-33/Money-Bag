// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:moneybook/domain/app/user_profile.dart';

class AuthState extends Equatable {
  final bool loading;
  final UserProfile profile;
  final CleanFailure failure;
  const AuthState({
    required this.loading,
    required this.profile,
    required this.failure,
  });

  AuthState copyWith({
    bool? loading,
    UserProfile? profile,
    CleanFailure? failure,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
      failure: failure ?? this.failure,
    );
  }

  factory AuthState.init() => AuthState(
      loading: false,
      profile: UserProfile.isEmpty(),
      failure: CleanFailure.none());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, profile, failure];
}
