// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class LogInBody extends Equatable {
  final String email;
  final String password;
  const LogInBody({
    required this.email,
    required this.password,
  });

  LogInBody copyWith({
    String? email,
    String? password,
  }) {
    return LogInBody(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LogInBody.fromMap(Map<String, dynamic> map) {
    return LogInBody(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogInBody.fromJson(String source) => LogInBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, password];
}
